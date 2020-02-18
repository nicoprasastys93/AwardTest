//
//  AwardController.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 14/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit
import SDWebImage
import Toast_Swift
import SideMenu
class AwardController:  UITableViewController{
    private let awardPresenter: AwardPresenter = AwardPresenter()
    
    private var data: [AwardModel]?
   
    var fetchingMore = false
    var endReached = false
    let leadingScreenForBatching: CGFloat = 10.0
    var cellIndexPathHeight: [IndexPath: CGFloat] = [:]
    var filter: Bool = false
    var filterData = [AwardModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupNavigationBarWithZeroShadow()
        setupAwardPresenter()
        setupTableView()
        setupSideMenu()
        awardPresenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Awards"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLeftMenuNavigationController"{
            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
            sideMenuNavigationController.setupNavigationBarWithZeroShadow()
            sideMenuNavigationController.statusBarEndAlpha = 0
            sideMenuNavigationController.alwaysAnimate = true
            sideMenuNavigationController.presentationStyle = SideMenuPresentationStyle.menuSlideIn;
            sideMenuNavigationController.presentationStyle.presentingEndAlpha = 0.8
            sideMenuNavigationController.presentationStyle.onTopShadowOpacity = 0.5
            sideMenuNavigationController.presentationStyle.onTopShadowRadius = 5
            sideMenuNavigationController.presentationStyle.onTopShadowColor = .black
            sideMenuNavigationController.pushStyle = .popWhenPossible;
            sideMenuNavigationController.menuWidth = view.frame.width * 0.75;
            print("toLeftMenuNavigationController")
        }else if segue.identifier == "toFileterViewController"{
            guard let segueFilter = segue.destination as? UINavigationController else {return}
            if segueFilter.viewControllers.count>0{
                let filterController = segueFilter.viewControllers.first as! FileterViewController
                let filterPresent = FilterPresenter(data: data!)
                filterController.filterPresenter = filterPresent
                filterController.delegate = self
            }
        }
    }

    private func setupSideMenu() {
        guard let sideMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController else{return}
        SideMenuManager.default.leftMenuNavigationController = sideMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AwardLoadingCell.self, forCellReuseIdentifier: "AwardLoadingCell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    
    private func setupAwardPresenter(){
        awardPresenter.delegate = self
    }
    
    @objc private func refreshData(){
        awardPresenter.refreshData()
        filter = false
    }
    
//    MARK: TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
//            let dt = filter!.count > 0 ? filter?.count : data?.count
            let count = filter ? self.filterData.count : self.data?.count
            return count ?? 0
        }else{
            return fetchingMore ? 1:0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let awardData = filter ? self.filterData : self.data
        if indexPath.section == 0{
            let awardCell = tableView.dequeueReusableCell(withIdentifier: "awardCell", for: indexPath) as! AwardCell
            
            awardCell.outletLabelItemType.text = awardData?[indexPath.row].award_type
            awardCell.outletLabelItemType.backgroundColor = awardPresenter.itemTypeBackground(itemType: (awardData?[indexPath.row].award_type)!)
            
            awardCell.outletImageViewItem.sd_setImage(with: URL(string: awardData![indexPath.row].award_image), placeholderImage: UIImage(named: ""))
            
            awardCell.outletLabelItemPoin.text = "  " + awardData![indexPath.row].award_poin + "  "
            
            awardCell.outletLabelItemName.text = awardData?[indexPath.row].award_name
            return awardCell
        }else{
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "AwardLoadingCell", for: indexPath) as! AwardLoadingCell
            loadingCell.spinner.startAnimating()
            return loadingCell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellIndexPathHeight[indexPath] = cell.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellIndexPathHeight[indexPath] ?? 200
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        if offsetY > contentHight - scrollView.frame.size.height * leadingScreenForBatching{
            if !fetchingMore && !endReached && !filter{
                beginBatchFeatch()
            }
        }
    }
    
    private func beginBatchFeatch(){
        fetchingMore = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        awardPresenter.loadMore { end, new_award in
            self.fetchingMore = false
            self.endReached = end
            self.data = (end == true) ? self.data:new_award
            self.tableView.reloadData()
            
            if end{
                DispatchQueue.main.async {
                    self.view.makeToast("", duration: 2, point: CGPoint(x: self.view.center.x, y: self.tableView.contentSize.height - 40), title: "No Awards Found", image: UIImage(named: "notification"), style: ToastStyle(), completion: nil)
                }
            }
        }
    }
}

extension AwardController: AwardPresenterDelegate{
    func awardPresenter(_ awardPresenter: AwardPresenter, loading: Bool) {
        
    }
    
    func awardPresenter(_ awardPresenter: AwardPresenter, didRecivedData: [AwardModel]) {
        data = didRecivedData
        tableView.reloadData()
    }
    
    func awardPresenter(_ awardPresenter: AwardPresenter, didRefreshData: [AwardModel]) {
        data = didRefreshData
        fetchingMore = false
        endReached = false
        filter = false
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}


extension AwardController: FilterViewControllerDelegate{
    func fileterViewController(fileterViewController: FileterViewController, filter: [AwardModel]) {
        self.filter = true
        filterData = filter
        tableView.reloadData()
    }
}
