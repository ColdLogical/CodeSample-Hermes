//
//  LoginView.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class LoginView : UIViewController, LoginNavigation, LoginPresenterToViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter : LoginViewToPresenterInterface = LoginPresenter()
        
        // MARK: - Instance Variables
        
        // MARK: - Outlets
        @IBOutlet var messageLabel: UILabel?
        @IBOutlet var passwordField: UITextField?
        @IBOutlet var usernameField: UITextField?
        
        // MARK: - Operational
        @IBAction func loginTapped(_ sender: AnyObject?) {
                let username = usernameField!.text
                let password = passwordField!.text
                
                if username == "" || password == "" {
                        if password == "" {
                                showMessage("Please enter a password")
                        }
                        
                        if username == "" {
                                showMessage("Please enter a username")
                        }
                } else {
                        presenter.userTappedLogin(username!, password: password!)
                }
        }
        
        @IBAction func registerTapped(_ sender: AnyObject?) {
                presenter.userTappedRegister()
        }
        
        // MARK: - View Interface
        func showMessage(_ message: String) {
                self.messageLabel!.isHidden = false
                self.messageLabel!.text = message
        }
        
}
