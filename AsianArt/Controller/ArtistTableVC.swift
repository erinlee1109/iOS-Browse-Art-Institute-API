//
//  ArtistTableVC.swift
//  AsianArt
//
//  Created by Yujeong Lee on 12/12/21.
//

import UIKit

class ArtistTableVC: UITableViewController {
    
    /// api + nib
    var artworksArray: [[String:Any?]] = []
    var artistName: String?
    var artistID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(artistID)
        /// api + nib
        let artistID_string = String(artistID!)
        let artistLink =  "https://api.artic.edu/api/v1/artworks/search?query[term][artist_ids]=\(artistID_string)&fields=id,title,artist_display,date_display,medium_display,image_id,place_of_origin"
        
        getAPIData(link: artistLink)
        
        let nib = UINib(nibName: "ArtworkTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArtworkTableViewCell")
        
        title = artistName
    }
    
    /// api + nib
    /// Pass the API link to the API.swift file to request data.
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artworksArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkTableViewCell", for: indexPath) as! ArtworkTableViewCell

        let artwork = artworksArray[indexPath.row]
        cell.titleLabel.text = artwork["title"] as? String
        /// catches if "artist_display" returns nil
        let artistLong = artwork["artist_display"] as? String
        if artistLong != nil {
            let components = artistLong!.components(separatedBy: "\n")
            let artistShort = components[0]
            cell.artistLabel.text = artistShort
        }
        
        cell.dateLabel.text = artwork["date_display"] as? String
        cell.mediumLabel.text = artwork["medium_display"] as? String
        
        /// display image
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
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
