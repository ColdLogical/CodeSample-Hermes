//
//  RegisterInteractor.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse

class RegisterInteractor: NSObject, RegisterInteractorInput {
        // MARK: - VIPER Stack
        lazy var presenter : RegisterInteractorOutput = RegisterPresenter()
        
        // MARK: - Instance Variables
        lazy var newUser : RegisterInteractorUser = PFUser()
        
        // MARK: - Operational
        func signUpFailed(error: NSError?) {
                presenter.signUpFailure(error)
        }
        
        func signUpSucceeded() {
                presenter.signUpSuccess()
        }
        
        // MARK: - Interactor Input
        func registerUser(username: String, password: String) {
                newUser.username = username
                newUser.password = password
                
                newUser.signUpInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                                self.signUpSucceeded()
                        } else {
                                self.signUpFailed(error)
                        }
                }
        }
}

extension PFUser : RegisterInteractorUser { }