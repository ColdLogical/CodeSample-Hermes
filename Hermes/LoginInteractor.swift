//
//  LoginInteractor.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
//import Parse

//extension PFUser : LoginInteractorUser { }

class LoginInteractor: NSObject, LoginPresenterToInteractorInterface {
        // MARK: - VIPER Stack
        lazy var presenter: LoginInteractorToPresenterInterface = LoginPresenter()

        // MARK: - Instance Variables
//        lazy var loginService : LoginInteractorUser.Type = PFUser.self

        // MARK: - Operational
        func loginFailed(_ error: NSError?) {
                presenter.failedLogin(error)
        }

        func loginSucceeded() {
                presenter.loginSuccess()
        }

        // MARK: - Interactor Input
        func login(withUsername username: String, andPassword password: String) {
//                loginService.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
//                        if user != nil {
//                                self.loginSucceeded()
//                        } else {
//                                self.loginFailed(error as NSError?)
//                        }
//                }
        }
}
