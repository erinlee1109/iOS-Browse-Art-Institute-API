//
//  ViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/29/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // data returned from API.swift is appended below into this array
    var artworksArray: [[String:Any?]] = []
    
    // outlets for Table View (infinite scroll screen)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // registering the .xib file
        let nib = UINib(nibName: "ArtworkTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArtworkTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()
    }
    
    func getAPIData() {
        // importing from the API.swift
        API.getArtworks() { (artworks) in
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
}

