//
//  ViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/29/21.
//

import UIKit
// CocoaPods reference https://guides.codepath.com/ios/CocoaPods#installing-cocoapods

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    // data returned from API.swift is appended below into this array
    var artworksArray: [[String:Any?]] = []
    var filteredData: [[String:Any?]] = [] // Search bar config
    
    // Search bar is implemented using the UISearchControllers (referenced CodePath search bar guide)
    var searchController: UISearchController!
    
    // outlets for Table View (infinite scroll screen)
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // loads artwork by default using this API link. Different artworks are fetched upon search.
        let defaultLink = "https://api.artic.edu/api/v1/artworks?fields=id,title,artist_display,date_display,image_id&limit=100"
        getAPIData(link: defaultLink)
        
        // register the .xib file
        let nib = UINib(nibName: "ArtworkTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArtworkTableViewCell")
        
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // underlying content is not obscured during a search
        navigationItem.hidesSearchBarWhenScrolling = false // the search bar doesn't hide when I scroll
        searchController.searchBar.sizeToFit()
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
        cell.artistLabel.text = artwork["artist_display"] as? String
        cell.dateLabel.text = artwork["date_display"] as? String
        
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
        let searchText = searchController.searchBar.text as String?
        // make sure only English alphabet searches are accepted to be passed as an API link
        let inputStatus = containsOnlyLetters(input: searchText!)
        if inputStatus == true {
            let beginURL = "https://api.artic.edu/api/v1/artworks/search?q="
            let endURL = "&fields=id,title,artist_display,date_display,image_id&limit=100"
            let linkName = beginURL + searchText! + endURL // force unwrapped searchText
            getAPIData(link: linkName)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ArtDetail") as? ArtDetailViewController {
            // carry over the selected cell's data to the detail view controller
            vc.artwork = artworksArray[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


