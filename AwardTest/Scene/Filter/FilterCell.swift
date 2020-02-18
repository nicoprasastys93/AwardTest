//
//  FilterCell.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 18/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var outletLabelValue: FilterValueView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
