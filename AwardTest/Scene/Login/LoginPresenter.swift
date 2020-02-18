//
//  LoginPresenter.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 14/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

protocol LoginPresenterDelegate: class{
    func loginPresenter(_ loginPresenter: LoginPresenter, detectedLogin: Bool)
    func loginPresenter(_ loginPresenter: LoginPresenter, alertTitle: String, alertMessage: String)
}

final class LoginPresenter {
    weak var delegate: LoginPresenterDelegate?
    
    private let loginModel: [LoginModel] = [
        LoginModel(email: "test@gmail.com"),
        LoginModel(email: "test2@gmail.com")
    ]
    
    private func trueEmail(email: String)->Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailpredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailpredicate.evaluate(with: email)
    }
    
    func userLogin(email: String){
        if trueEmail(email: email){
            print("Go")
            if loginModel.contains(where: { (element) -> Bool in
                if element.email == email{
                    return true
                }else{
                    return false
                }
            }){
                delegate?.loginPresenter(self, detectedLogin: true)
            }else{
                delegate?.loginPresenter(self, alertTitle: "Failed to Login", alertMessage: "Email Address is not exists...")
            }
        }else{
            delegate?.loginPresenter(self, alertTitle: "Failed to Login", alertMessage: "Failed Format...")
        }
    }
}
