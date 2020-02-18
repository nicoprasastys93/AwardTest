//
//  AwardPresenter.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 14/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

protocol AwardPresenterDelegate: class{
    func awardPresenter(_ awardPresenter: AwardPresenter, loading: Bool)
    func awardPresenter(_ awardPresenter: AwardPresenter, didRecivedData: [AwardModel])
    func awardPresenter(_ awardPresenter: AwardPresenter, didRefreshData: [AwardModel])
}

final class AwardPresenter {
    weak var delegate: AwardPresenterDelegate?
    
    enum ItemType: String {
        case Vouchers = "Vouchers"
        case Products = "Products"
        case Giftcard = "Giftcard"
    }
    
    private var awardModel: [AwardModel] = [
        AwardModel(award_type: ItemType.Vouchers.rawValue, award_poin: 500000.rupiahFormat(), award_name: "Voucher Card IDR 500.0000", award_image: "https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg"),
        AwardModel(award_type: ItemType.Products.rawValue, award_poin: 250000.rupiahFormat(), award_name: "Chain Product", award_image: "https://cdn.pixabay.com/photo/2015/09/19/20/54/chain-947713_1280.jpg"),
        AwardModel(award_type: ItemType.Giftcard.rawValue, award_poin: 100000.rupiahFormat(), award_name: "Gift Card IDR 1.000.000", award_image: "https://cdn.pixabay.com/photo/2015/01/12/17/40/padlock-597495_1280.jpg"),
        AwardModel(award_type: ItemType.Vouchers.rawValue, award_poin: 500000.rupiahFormat(), award_name: "Voucher Card IDR 500.0000", award_image: "https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg"),
        AwardModel(award_type: ItemType.Products.rawValue, award_poin: 250000.rupiahFormat(), award_name: "Chain Product", award_image: "https://cdn.pixabay.com/photo/2015/09/19/20/54/chain-947713_1280.jpg"),
        AwardModel(award_type: ItemType.Giftcard.rawValue, award_poin: 100000.rupiahFormat(), award_name: "Gift Card IDR 1.000.000", award_image: "https://cdn.pixabay.com/photo/2015/01/12/17/40/padlock-597495_1280.jpg"),
        AwardModel(award_type: ItemType.Vouchers.rawValue, award_poin: 500000.rupiahFormat(), award_name: "Voucher Card IDR 500.0000", award_image: "https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg"),
        AwardModel(award_type: ItemType.Products.rawValue, award_poin: 250000.rupiahFormat(), award_name: "Chain Product", award_image: "https://cdn.pixabay.com/photo/2015/09/19/20/54/chain-947713_1280.jpg"),
        AwardModel(award_type: ItemType.Giftcard.rawValue, award_poin: 100000.rupiahFormat(), award_name: "Gift Card IDR 1.000.000", award_image: "https://cdn.pixabay.com/photo/2015/01/12/17/40/padlock-597495_1280.jpg")
        
    ]
    
    func loadData(){
        delegate?.awardPresenter(self, didRecivedData: awardModel)
    }
    
    func loadMore(completion: @escaping(_ end: Bool,_ data: [AwardModel]) -> Void){
        let awards: [AwardModel] = [
            AwardModel(award_type: ItemType.Vouchers.rawValue, award_poin: 500000.rupiahFormat(), award_name: "Voucher Card IDR 500.0000", award_image: "https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg"),
            AwardModel(award_type: ItemType.Products.rawValue, award_poin: 250000.rupiahFormat(), award_name: "Chain Product", award_image: "https://cdn.pixabay.com/photo/2015/09/19/20/54/chain-947713_1280.jpg"),
            AwardModel(award_type: ItemType.Giftcard.rawValue, award_poin: 100000.rupiahFormat(), award_name: "Gift Card IDR 1.000.000", award_image: "https://cdn.pixabay.com/photo/2015/01/12/17/40/padlock-597495_1280.jpg"),
            AwardModel(award_type: ItemType.Vouchers.rawValue, award_poin: 500000.rupiahFormat(), award_name: "Voucher Card IDR 500.0000", award_image: "https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg"),
            AwardModel(award_type: ItemType.Products.rawValue, award_poin: 250000.rupiahFormat(), award_name: "Chain Product", award_image: "https://cdn.pixabay.com/photo/2015/09/19/20/54/chain-947713_1280.jpg"),
            AwardModel(award_type: ItemType.Giftcard.rawValue, award_poin: 100000.rupiahFormat(), award_name: "Gift Card IDR 1.000.000", award_image: "https://cdn.pixabay.com/photo/2015/01/12/17/40/padlock-597495_1280.jpg"),
            AwardModel(award_type: ItemType.Vouchers.rawValue, award_poin: 500000.rupiahFormat(), award_name: "Voucher Card IDR 500.0000", award_image: "https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg"),
            AwardModel(award_type: ItemType.Products.rawValue, award_poin: 250000.rupiahFormat(), award_name: "Chain Product", award_image: "https://cdn.pixabay.com/photo/2015/09/19/20/54/chain-947713_1280.jpg"),
            AwardModel(award_type: ItemType.Giftcard.rawValue, award_poin: 100000.rupiahFormat(), award_name: "Gift Card IDR 1.000.000", award_image: "https://cdn.pixabay.com/photo/2015/01/12/17/40/padlock-597495_1280.jpg")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.awardModel.count < 18{
                self.awardModel.append(contentsOf: awards)
                return completion(false, self.awardModel)
            }else{
                return completion(true, self.awardModel)
            }
        }
    }
    
    func refreshData(){
        self.awardModel = Array(awardModel.prefix(9))
        delegate?.awardPresenter(self, didRefreshData: awardModel)
    }
    
    func itemTypeBackground(itemType: String) -> UIColor{
        if itemType == ItemType.Vouchers.rawValue{
            return .blue
        }else if itemType == ItemType.Products.rawValue{
            return .orange
        }else{
            return .green
        }
    }
}
