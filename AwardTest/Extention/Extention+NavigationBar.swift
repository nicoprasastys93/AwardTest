//
//  Extention+NavigationBar.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 16/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupNavigationBarWithZeroShadow(){
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.barTintColor = .white
    }
}
