//
//  DetailViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 7/21/21.
//

import Lottie
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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        self.setUpLabelTap()
        
        // how do I make this into a function?
        if let image_id = artwork["image_id"] as? String {
            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
            let imageURL = URL(string: iiifLink)
            
            // created an extension to load remote URL into UIImageView
            artImageView.load(url:imageURL!)
//            artImageView.af.setImage(withURL: imageURL!)
            artImageView.backgroundColor = .lightGray
        }
        
        artDetailTitle.text = artwork["title"] as? String
        artistDetailTitle.text = artwork["artist_display"] as? String
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.infoView.frame.origin.y + self.infoView.frame.size.height)
        self.scrollView.bounces = true
        self.scrollView.showsVerticalScrollIndicator = true

        // Do any additional setup after loading the view.
    }
    
    // outlet from the tap gesture recog in the details view
    @IBAction func artistTapped(_ sender: UITapGestureRecognizer) {
        if let artistVC = storyboard?.instantiateViewController(withIdentifier: "Artist") as? ArtistTableVC {
            artistVC.artistID = artwork["artist_id"] as? Int
            artistVC.artistName = artwork["artist_display"] as? String
            navigationController?.pushViewController(artistVC, animated: true)
        }
    }
    
    // setting up so that UIText tap will be recognized for artist tapped
    func setUpLabelTap(){
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.artistTapped(_:)))
        self.artistDetailTitle.isUserInteractionEnabled = true
        self.artistDetailTitle.addGestureRecognizer(labelTap)
    }
    
    /// allow downloading image and share to social media
    @objc func shareTapped(){
        guard let image = artImageView.image?.pngData() else {
            print("No image found")
            return
        }
        print(type(of: image))
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

/// load a remote image URL into UIImageView
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
