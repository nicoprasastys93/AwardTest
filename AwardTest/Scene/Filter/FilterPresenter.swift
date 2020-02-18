//
//  FilterPresenter.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 17/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol FilterPresenterDelegate: class {
    func filterPresenter(_ filterPresenter: FilterPresenter, _ data: [AwardModel])
}

final class FilterPresenter{
    var delegate: FilterPresenterDelegate?
    var data: [AwardModel]?
    
    
    
    var minPoin: Int{
        get{
            let value = data?.map{$0.award_poin}.min()!
            if let number =  parseInt(value: value!){
                return number
            }
            return 0
        }
    }
    
    var maxPoin: Int{
        get{
            let value = data?.map{$0.award_poin}.max()!
            if let number =  parseInt(value: value!){
                return number
            }
            return 0
        }
    }
    
    var currentPoin: Int?
    
    var isPoint: Bool{
        get{
            return currentPoin != nil
        }
    }
    
    var historyFilterData: [String]?{
        get{
            var newDb = [String]()
            let db = Database.shared.selectedDB(query: "SELECT * FROM dt_filter;")
            if db.count>0{
                db.forEach { (value) in
                    var val = value
                    if value.contains("|"){
                        val = value.components(separatedBy: "|").joined(separator: ", ")
                    }
                    newDb.append(val)
                }
                return newDb
            }
            return []
        }
    }
    
    var checkBoxGroup: [BEMCheckBox]?
    
    
    private var typeValue: [String]{
        get{
            return checkBoxGroup?.filter{$0.on == true}.map{$0.restorationIdentifier} as! [String]
        }
    }
    
    private var isType: Bool{
        get{
            return typeValue.count > 0
        }
    }
    
    private var isAllType: Bool{
        get{
            return typeValue.contains(checkBoxGroup![0].restorationIdentifier!)
        }
    }
    
    private var allTypeValue: [String]{
        get{
            return ["Vouchers", "Products", "Giftcard"]
        }
    }
    
    private var currentType: [String]{
        get{
            return isAllType ? allTypeValue : typeValue
        }
    }
    
    
    init(data: [AwardModel]) {
        self.data = data
    }
    
    func minMaxSlidePoin(value: Float)->String{
        if Int(value) <= minPoin{
            return "Poin: \(Int(value).poinFormat())"
        }else{

            return "Poin: \(minPoin) - \(Int(value).poinFormat())"
        }
    }
    
    func saveFilterValueToDB(){
        Database.shared.insertDB(query: "INSERT INTO dt_filter (Filter) values ('\(currentPoin!)');")
        if typeValue.count > 0{
            let newCheckBoxValue = isAllType ? allTypeValue : typeValue
            Database.shared.insertDB(query: "INSERT INTO dt_filter (Filter) values ('\(Array(newCheckBoxValue).joined(separator: "|"))');")
        }
        filterResult()
    }

    fileprivate func filterResult(){
        var filterAwarModel = [AwardModel]()
        if isType{
            for value in currentType{
                let new = data?.filter{$0.award_type == value}
                filterAwarModel.append(contentsOf: new!)
            }
            filterAwarModel = filterAwarModel.filter{parseInt(value: $0.award_poin)! >= minPoin && parseInt(value: $0.award_poin)! <= currentPoin!}
        }else{
            filterAwarModel = data!.filter{parseInt(value: $0.award_poin)! >= minPoin && parseInt(value: $0.award_poin)! <= currentPoin!}
        }
        delegate?.filterPresenter(self, filterAwarModel)
    }
    
    
    func setupBEMCheckBox(){
        checkBoxGroup!.forEach { (checkbox) in
            checkbox.setFilterCheckBox()
        }
    }
    
    func didSelectedCell(index: Int){
        var filterAwarModel = [AwardModel]()
        let history = historyFilterData![index]
        
        let isFilterPoin = parseInt(value: history) != nil
        
        if isFilterPoin{
            filterAwarModel = data!.filter{parseInt(value: $0.award_poin)! <= parseInt(value: history)!}
        }else{
            for value in history.components(separatedBy: ", "){
                let new = data?.filter{$0.award_type == value}
                filterAwarModel.append(contentsOf: new!)
            }
        }
        delegate?.filterPresenter(self, filterAwarModel)
    }
    
    func clearFilter(){
        Database.shared.deletedDB(tableName: "dt_filter")
        delegate?.filterPresenter(self, data!)
    }
    
    func parseInt(value: String)->Int?{
        return Int(value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? nil
    }
}
