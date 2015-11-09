//
//  FitnessTableViewCell.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/9.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class FitnessTableViewCell: UITableViewCell {

    @IBOutlet weak var fitnessImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
