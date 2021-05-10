//
//  ViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/29/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    // Search bar is implemented using the UISearchControllers (referencing CodePath search bar guide)
    
    // data returned from API.swift is appended below into this array
    var artworksArray: [[String:Any?]] = []
    var filteredData: [[String:Any?]] = [] // Search bar config
    
    var searchController: UISearchController! // from CodePath search bar guide
    
    // outlets for Table View (infinite scroll screen)
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // registering the .xib file
        let nib = UINib(nibName: "ArtworkTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArtworkTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
                 
        getAPIData()
        
        // filteredData = artworksArray
        
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        // underlying content is not obscured during a search
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        // set this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
    }
    
    func getAPIData() {
        // importing from the API.swift
        API.getArtworks(link: "https://api.artic.edu/api/v1/artworks?fields=id,title,artist_display,date_display&limit=10") { (artworks) in
            guard let artworks = artworks else {
                return
            }
            self.artworksArray = artworks
            self.tableView.reloadData()
        }
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
        cell.artImage.backgroundColor = .lightGray
        return cell
        
        // this works the initial way with the hard coded data
//        cell.titleLabel.text = myTitles[indexPath.row]
//        cell.artistLabel.text = myArtists[indexPath.row]
//        cell.dateLabel.text = myDates[indexPath.row]
//        cell.artImage.backgroundColor = .lightGray
//        return cell
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            let beginURL = "https://api.artic.edu/api/v1/artworks/search?q="
            let endURL = "&fields=id,title,artist_display,date_display&limit=10"
            let linkName = beginURL + searchText + endURL
            
            API.getArtworks(link: linkName) { (artworks) in
                guard let artworks = artworks else {
                    return
                }
                self.artworksArray = artworks
                self.tableView.reloadData()
            }
        }
    }

    
    // Asks the object to update the search results for a specified controller.
//    func updateSearchResultsForSearchController(searchContoller: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            let beginURL = "https://api.artic.edu/api/v1/artworks/search?q="
//            let endURL = "&fields=id,title,artist_display,date_display&limit=30"
//            let linkName = beginURL + searchText + endURL
//            API.getArtworks(link: linkName) { (artworks) in
//                guard let artworks = artworks else {
//                    return
//                }
//                self.artworksArray = artworks
//                self.tableView.reloadData()
//            }
//        }
//    }
}


