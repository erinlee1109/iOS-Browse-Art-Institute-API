//
//  ArtistViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 7/22/21.
//

import UIKit

class ArtistViewController: UIViewController {

    @IBOutlet weak var artistName: UILabel!
    
    var artist: Any??
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.artistName.text = artist as? String;
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
