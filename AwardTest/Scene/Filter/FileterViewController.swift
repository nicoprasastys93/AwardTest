//
//  FileterViewController.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 16/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol FilterViewControllerDelegate {
    func fileterViewController(fileterViewController: FileterViewController, filter: [AwardModel])
}

class FileterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var outletButtonReset: FilterValueView!{
        didSet{
            outletButtonReset.text = "Clear All Filter"
            outletButtonReset.imageView.isHidden = true
            outletButtonReset.label.textAlignment = .center
            outletButtonReset.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearHistoryFilter)))
            outletButtonReset.isHidden = !(filterPresenter!.historyFilterData!.count > 1)
        }
    }
    
    @IBOutlet weak var outletLabelPoinMin: UILabel!{
        didSet{
            outletLabelPoinMin.text = String(filterPresenter!.minPoin.rupiahFormat())
        }
    }
    @IBOutlet weak var outletLabelPoinMax: UILabel!{
        didSet{
            outletLabelPoinMax.text = String(filterPresenter!.maxPoin.rupiahFormat())
        }
    }
    
    @IBOutlet weak var outletSlideBarPoin: UISlider!{
        didSet{
            let min = filterPresenter!.minPoin
            let max = filterPresenter!.maxPoin
            outletSlideBarPoin.minimumValue = Float(min)
            outletSlideBarPoin.maximumValue = Float(max)
            outletSlideBarPoin.value = Float(Double(min) + (0.2 * Double(max)))
            
            filterPresenter?.currentPoin = Int(outletSlideBarPoin.value)
        }
    }
    @IBOutlet weak var outletButtonAllType: BEMCheckBox!
    @IBOutlet weak var outletButtonVoucher: BEMCheckBox!
    @IBOutlet weak var outletButtonProduct: BEMCheckBox!
    @IBOutlet weak var outletButtonOther: BEMCheckBox!

    private var checkBoxGroup : [BEMCheckBox]!
    
    var delegate: FilterViewControllerDelegate?
    
    var filterPresenter: FilterPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupNavigationBarWithZeroShadow()
        setupTitleLabel()
        setupRighBarButtonItem()
        filterPresenter?.checkBoxGroup = [outletButtonAllType, outletButtonVoucher, outletButtonProduct, outletButtonOther]
        filterPresenter?.setupBEMCheckBox()
        filterPresenter?.delegate = self
    }
    
    private func setupTitleLabel(){
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 70, height: view.frame.height))
        title.text = "Filter"
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = title
    }
    
    private func setupRighBarButtonItem(){
        let rightBar = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(setupRighBarButtonItemFunc))
        rightBar.tintColor = .black
        navigationItem.rightBarButtonItem = rightBar
    }
    
    @objc private func setupRighBarButtonItemFunc(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func clearHistoryFilter(){
        filterPresenter?.clearFilter()
    }
    
    @IBAction func poinSlide(_ sender: UISlider) {
        filterPresenter?.currentPoin! = Int(sender.value)
    }
    
    //Save Filter Data
    @IBAction func filterNow(_ sender: Any) {
        filterPresenter?.saveFilterValueToDB()
    }
}

extension FileterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPresenter?.historyFilterData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        if filterPresenter?.parseInt(value: filterPresenter!.historyFilterData![indexPath.row]) != nil{
            cell.outletLabelValue.text = "Poin: \(filterPresenter!.minPoin.poinFormat()) - \(Int(filterPresenter!.historyFilterData![indexPath.row])!.poinFormat())"
        }else{
            cell.outletLabelValue.text = "Type: \(filterPresenter!.historyFilterData![indexPath.row])"
        }
        
        return cell
    }
}

extension FileterViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterPresenter?.didSelectedCell(index: indexPath.row)
    }
}

extension FileterViewController: BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox == outletButtonAllType{
            if checkBox.on{
                outletButtonVoucher.on = false
                outletButtonProduct.on = false
                outletButtonOther.on = false
            }
        }else{
            outletButtonAllType.on = false
        }
    }
}

extension FileterViewController: FilterPresenterDelegate{
    func filterPresenter(_ filterPresenter: FilterPresenter, _ data: [AwardModel]) {
        delegate?.fileterViewController(fileterViewController: self, filter: data)
        dismiss(animated: true, completion: nil)
    }
}
