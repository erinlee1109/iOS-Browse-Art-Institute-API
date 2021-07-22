//
//  DetailViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 7/21/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var artDetailTitle: UILabel!
    @IBOutlet weak var artistDetailTitle: UILabel!
    
    var artwork: [String: Any?] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image_id = artwork["image_id"] as? String {
            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
            let imageURL = URL(string: iiifLink)
            artImageView.af.setImage(withURL: imageURL!)
            artImageView.backgroundColor = .lightGray
        }
        
        artDetailTitle.text = artwork["title"] as? String
        artistDetailTitle.text = artwork["artist_display"] as? String
        
        
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.infoView.frame.origin.y + self.infoView.frame.size.height)
        self.scrollView.bounces = true
        self.scrollView.showsVerticalScrollIndicator = true

        // Do any additional setup after loading the view.
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
