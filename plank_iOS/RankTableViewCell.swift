//
//  RankTableViewCell.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/24.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
