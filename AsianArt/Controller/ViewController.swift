//
//  ViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/29/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // hard coding data for now (apr29)
    //let myArtists = ["Na Hyesok", "Kara Walker", "Louise Bourgeois", "Mary Cassatt"]
        
//    let myTitles = ["Pine of Success and Oumayagashi, Asakusa River (Asakusagawa Shubi no matsu Oumayagashi), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "Asakusa River, Great Riverbank, Miyato River (Asakusagawa Okawabata Miyatogawa), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "Yanagishima, from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "Irises at Horikiri (Horikiri no hanashobu), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "Irises at Horikiri (Horikiri no hanashobu), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "Kinryuzan Temple at Asakusa (Asakusa Kinryuzan), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "Precincts of Kameido Tenjin Shrine (Kameido Tenjin keidai), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "Nippori, from the series \"Famous Places in the Eastern Capital (Toto meisho)\"", "Coffee Pot", "Bamboo Yards and Kyo Bridge (Kyobashi Takegashi), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\"", "The City Flourishing, Tanabata Festival (Shichu han\'ei Tanabata Matsuri), from the series “One Hundred Famous Views of Edo (Meisho Edo hyakkei)”", "Old Man\'s Teahouse, Meguro (Meguro Jijigachaya), from the series \"One Hundred Famous Views of Edo (Meisho Edo hyakkei)\""]
//
//    let myArtists = ["Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Francis Crump\nEnglish, active 1741-73\nLondon, England", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858", "Utagawa Hiroshige 歌川 広重\nJapanese, 1797-1858"]
//
//    let myDates = ["1856", "1857", "1857", "1857", "1857", "1856", "1856", "c. 1835/38", "1771/72", "1857", "1857", "1857"]
    
    var artworksArray: [[String:Any?]] = []
    
    // outlet for Table View
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ArtworkTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArtworkTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        getAPIData()
        
    }
    
    func getAPIData() {
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
        // prototype cell when it is specified as 1 (before creating the nib file)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkTableViewCell", for: indexPath) as! ArtworkTableViewCell
        
        let artwork = artworksArray[indexPath.row]
        cell.titleLabel.text = artwork["title"] as? String
        cell.artistLabel.text = artwork["artist_display"] as? String
        cell.dateLabel.text = artwork["date_display"] as? String
        cell.artImage.backgroundColor = .lightGray
        return cell
        
        // this works the initial way with the hard coded data
        // each cell's textlabel is the artist name
//        cell.titleLabel.text = myTitles[indexPath.row]
//        cell.artistLabel.text = myArtists[indexPath.row]
//        cell.dateLabel.text = myDates[indexPath.row]
//        cell.artImage.backgroundColor = .lightGray
//        return cell
        
    }
}

