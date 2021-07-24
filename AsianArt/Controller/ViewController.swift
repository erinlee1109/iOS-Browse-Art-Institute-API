//
//  ViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/29/21.
//

import UIKit
import Lottie
// CocoaPods reference https://guides.codepath.com/ios/CocoaPods#installing-cocoapods

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    // outlets for Table View (infinite scroll screen)
    @IBOutlet weak var tableView: UITableView!
    
    // data returned from API.swift is appended below into this array
    var artworksArray: [[String:Any?]] = []
    var filteredData: [[String:Any?]] = [] // Search bar config
    
    // Search bar is implemented using the UISearchControllers (referenced CodePath search bar guide)
    var searchController: UISearchController!
    
    // global var for the Lottie animation
    var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // animation (added jul 23)
        /*
        animationView = .init(name: "70021-abstract-painting-loader")
        animationView?.frame = view.bounds
        animationView?.play() */
        startAnimation()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // loads artwork by default using this API link. Different artworks are fetched upon search.
        let defaultLink = "https://api.artic.edu/api/v1/artworks?fields=id,title,artist_display,date_display,medium_display,image_id,place_of_origin&limit=100"
        getAPIData(link: defaultLink)
                
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.stopAnimation), userInfo: nil, repeats: false)
        
        // register the .xib file
        let nib = UINib(nibName: "ArtworkTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArtworkTableViewCell")
        
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // underlying content is not obscured during a search
        navigationItem.hidesSearchBarWhenScrolling = false // the search bar doesn't hide when I scroll
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Explore new art with any keywords"
        tableView.tableHeaderView = searchController.searchBar
        // set this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
    }
    
    // Pass the API link to the API.swift file to request data.
    func getAPIData(link: String) {
        // importing from the API.swift
        API.getArtworks(link: link) { (artworks) in
            guard let artworks = artworks else {
                return
            }
            self.artworksArray = artworks
            self.tableView.reloadData()
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return cells however many artists there are in the data
        return artworksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // each cell's textlabels are updated from the API data
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkTableViewCell", for: indexPath) as! ArtworkTableViewCell
        let artwork = artworksArray[indexPath.row]
        cell.titleLabel.text = artwork["title"] as? String
        
        // catches if "artist_display" returns nil
        let artistLong = artwork["artist_display"] as? String
        if artistLong != nil {
            let components = artistLong!.components(separatedBy: "\n")
            let artistShort = components[0]
            cell.artistLabel.text = artistShort
        }
        
//        let artistLong = artwork["artist_display"] as? String
//        let components = artistLong.components(separatedBy: "\n")
//        let artistShort = components[0]
//        cell.artistLabel.text = artistShort
        
        cell.dateLabel.text = artwork["date_display"] as? String
        cell.mediumLabel.text = artwork["medium_display"] as? String
        
        // display image
        if let image_id = artwork["image_id"] as? String {
            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
            let imageURL = URL(string: iiifLink)
            cell.artImage.af.setImage(withURL: imageURL!)
            cell.artImage.backgroundColor = .lightGray
        }
        return cell
    }
    
    // checks if user input contains only numbers and English characters (users cannot search in other language)
    // function adapted from Stack Overflow https://stackoverflow.com/questions/29520618/how-can-i-check-if-a-string-contains-letters-in-swift
    func containsOnlyLetters(input: String) -> Bool {
       for chr in input {
        if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr >= "0" && chr <= "9")) {
             return false
          }
       }
       return true
    }
    
    // request new data using the updated API link when user searches
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.placeholder = "Search 'Korea', 'bedroom', 'surreal'..."
        
        let searchText = searchController.searchBar.text as String?
        // make sure only English alphabet searches are accepted to be passed as an API link
        let inputStatus = containsOnlyLetters(input: searchText!)
        if inputStatus == true {
            let beginURL = "https://api.artic.edu/api/v1/artworks/search?q="
            let endURL = "&fields=id,title,artist_display,date_display,medium_display,image_id,place_of_origin&limit=100"
            let linkName = beginURL + searchText! + endURL // force unwrapped searchText
            getAPIData(link: linkName)
        }
    }
    
    // added Jul 23
    func startAnimation(){
        // let piggyName = "70036-milestone-completed-2"
        let abstName = "70021-abstract-painting-loader"
        // created object of a class
        animationView = .init(name: abstName)
        //animationView = .init(name: "70021-abstract-painting-loader")
        
        // setting the size
        animationView.frame = CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 100, width: 200, height: 200) // we want it to be in the middle third/middle half
        //fit the animation
        animationView.contentMode = .scaleAspectFit // not scaleAspectFull because the animation can get distorted or cut off
        view.addSubview(animationView) // adding a subview so we can remove the subview after
        // loop the animation & set the speed
        animationView.loopMode = .loop
        animationView.animationSpeed = 5
        animationView.play()
    }
    
    @objc func stopAnimation(){
        animationView?.stop()
        view.subviews.last?.removeFromSuperview()
    }
    
    // passing the data to DetailViewController when user taps a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            // carry over the selected cell's data to the detail view controller
            vc.artwork = artworksArray[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


