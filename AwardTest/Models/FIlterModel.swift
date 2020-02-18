//
//  FIlterModel.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 18/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import Foundation

struct FilterModel: Decodable{
    let allType: String
    let vouchers: String
    let products: String
    let giftCard: String
    
    init(allType: String, vouchers: String, products: String, giftCard: String) {
        self.allType = allType
        self.vouchers = vouchers
        self.products = products
        self.giftCard = giftCard
    }
}
