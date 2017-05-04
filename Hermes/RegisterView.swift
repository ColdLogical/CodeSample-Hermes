//
//  RegisterView.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class RegisterView: UIViewController, RegisterPresenterToViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter: RegisterViewToPresenterInterface = RegisterPresenter()

        // MARK: - Instance Variables

        // MARK: - Outlets
        @IBOutlet var messageLabel: UILabel?
        @IBOutlet var passwordField: UITextField?
        @IBOutlet var usernameField: UITextField?

        // MARK: - Operational
        @IBAction func registerTapped(_ sender: AnyObject?) {
                guard let username = usernameField?.text,
                        username != "" else {
                                show(message: "Please enter a username")
                                return
                }

                guard let password = passwordField?.text,
                        password != "" else {
                                show(message: "Please enter a password")
                                return
                }

                presenter.userTappedRegister(withUsername: username, andPassword: password)
        }

        // MARK: - View Interface
        func show(message: String) {
                messageLabel?.isHidden = false
                messageLabel?.text = message
        }
}
