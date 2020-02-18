//
//  Extention+BEMCheckBox.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 17/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit
import BEMCheckBox

extension BEMCheckBox{
    func setFilterCheckBox(){
        self.boxType = .square
        self.lineWidth = 2
        self.animationDuration = 0.5
        self.offAnimationType = .bounce
        self.offFillColor = .white
        self.onAnimationType = .bounce
        self.onFillColor = .systemBlue
        self.onTintColor = .white
        self.onCheckColor = .white
        
        
    }
}
