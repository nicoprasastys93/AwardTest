//
//  SlideViewController.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 15/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit
import SideMenu

class SlideViewController: UIViewController {
    @IBOutlet weak var outletTableView: UITableView!
    
    let list = ["Home", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SlideViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlideCell", for: indexPath) as! SlideCell
        cell.outletLabelOption.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }else if indexPath.row == 1{
            guard let login = storyboard?.instantiateViewController(identifier: "LoginController") as? LoginController else {
                return
            }
            
            login.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(login, animated: true, completion: nil)
            }

        }
    }
}

extension SlideViewController: UITableViewDelegate{
    
}
