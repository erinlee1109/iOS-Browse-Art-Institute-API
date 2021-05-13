//
//  ArtworkTableViewCell.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/29/21.
//

import UIKit

class ArtworkTableViewCell: UITableViewCell {

    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
