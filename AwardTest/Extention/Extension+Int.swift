//
//  Extension+UIViewController.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 14/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

extension Int{
    func rupiahFormat() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
           return "IDR " + formattedTipAmount
        }
        return ""
    }
    
    func poinFormat() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
           return formattedTipAmount
        }
        return ""
    }
    
    
}
