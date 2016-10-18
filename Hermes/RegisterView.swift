//
//  RegisterView.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class RegisterView : UIViewController, RegisterPresenterToViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter : RegisterViewToPresenterInterface = RegisterPresenter()
        
        // MARK: - Instance Variables
        
        // MARK: - Outlets
        @IBOutlet var messageLabel: UILabel?
        @IBOutlet var passwordField: UITextField?
        @IBOutlet var usernameField: UITextField?
        
        // MARK: - Operational
        @IBAction func registerTapped(_ sender: AnyObject?) {
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
                        presenter.userTappedRegister(username!, password: password!)
                }
        }
        
        // MARK: - View Interface
        func showMessage(_ message: String) {
                if let ml = self.messageLabel {
                        ml.isHidden = false
                        ml.text = message
                }
        }
}
