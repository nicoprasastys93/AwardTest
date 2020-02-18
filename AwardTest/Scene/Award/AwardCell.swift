//
//  AwardCell.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 14/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class AwardCell: UITableViewCell {
    @IBOutlet weak var outletLabelItemType: UILabel!{
        didSet{
            outletLabelItemType.textColor = .white
            outletLabelItemType.layer.cornerRadius = 5
            outletLabelItemType.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var outletImageViewItem: UIImageView!{
        didSet{
            outletImageViewItem.layer.cornerRadius = 5
            outletImageViewItem.layer.shadowColor = UIColor.black.cgColor
            outletImageViewItem.layer.shadowOpacity = 1
            outletImageViewItem.layer.shadowOffset = .zero
            outletImageViewItem.layer.shadowRadius = 10
        }
    }
    @IBOutlet weak var outletLabelItemPoin: UILabel!
    @IBOutlet weak var outletLabelItemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
