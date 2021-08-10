//
//  ArtImageOnlyViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 7/25/21.
//

// Jul 25 problems: Clicking on the image doesn't lead me to a different screen

import UIKit

class ArtImageOnlyViewController: UIViewController {
    
    @IBOutlet weak var artImageOnly: UIImageView!
    
    var imageID: Any??

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let image_id = imageID as? String {
            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
            let imageURL = URL(string: iiifLink)
            artImageOnly.af.setImage(withURL: imageURL!)
            artImageOnly.backgroundColor = .lightGray
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
