//
//  LoginController.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 14/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var outletLabelLoginDesc: UILabel!{
        didSet{
            outletLabelLoginDesc.text = "Enter your email address" + "\n" + "to sign in and continue"
            outletLabelLoginDesc.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var outletButtonLoginSignIn: UIButton!{
        didSet{
            outletButtonLoginSignIn.layer.cornerRadius = 6
            outletButtonLoginSignIn.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var outletTFieldEmail: UITextField!
    
    private let loginPresented: LoginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginPresenter()
    }

    private func setupLoginPresenter(){
        loginPresented.delegate = self
    }
    
    @objc private func logIn(){
        loginPresented.userLogin(email: outletTFieldEmail.text!)
    }
}

extension LoginController: LoginPresenterDelegate{
    func loginPresenter(_ loginPresenter: LoginPresenter, detectedLogin: Bool) {
        guard let awardNav =  storyboard?.instantiateViewController(identifier: "AwardNavigationController") as? AwardNavigationController else {
            return
        }
        awardNav.modalPresentationStyle = .fullScreen
        present(awardNav, animated: true, completion: nil)
    }
    
    func loginPresenter(_ loginPresenter: LoginPresenter, alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
