//
//  ArtistTableViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 12/12/21.
//

/*
check if artist ID valid
if valid
push screen
fetch data
display data
*/

import UIKit
import Alamofire
import AlamofireImage

class ArtistTableViewController: UITableViewController {
    
    var artworksArray: [[String:Any?]] = []
    var artistName: String?
    var artistID: Int?
    var artistURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let artistID = artistID {
            let artistURL = API.getWorkByArtist(artistID: artistID)
            getAPIData(link: artistURL)
        } else {
            print("No work avail")
        }

        let nib = UINib(nibName: "ArtworkTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArtworkTableViewCell")
        
        title = artistName
    }
    
    func getAPIData(link: String) {
        API.getArtworks(link: link) { (artworks) in
            guard let artworks = artworks else {
                return
            }
            self.artworksArray = artworks
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworksArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkTableViewCell", for: indexPath) as! ArtworkTableViewCell

        let artwork = artworksArray[indexPath.row]
        cell.titleLabel.text = artwork["title"] as? String
        let artistLong = artwork["artist_display"] as? String
        if artistLong != nil {
            let components = artistLong!.components(separatedBy: "\n")
            let artistShort = components[0]
            cell.artistLabel.text = artistShort
        }
        
        cell.dateLabel.text = artwork["date_display"] as? String
        cell.mediumLabel.text = artwork["medium_display"] as? String
        
        if let image_id = artwork["image_id"] as? String {
            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
            let imageURL = URL(string: iiifLink)
            cell.artImage.af.setImage(withURL: imageURL!)
            cell.artImage.backgroundColor = .lightGray
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            // carry over the selected cell's data to the detail view controller
            vc.artwork = artworksArray[indexPath.row]
//            print("index row", artworksArray[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
