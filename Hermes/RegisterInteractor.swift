//
//  RegisterInteractor.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse

extension PFUser : RegisterInteractorUser { }

class RegisterInteractor: NSObject, RegisterPresenterToInteractorInterface {
        // MARK: - VIPER Stack
        lazy var presenter : RegisterInteractorToPresenterInterface = RegisterPresenter()
        
        // MARK: - Instance Variables
        lazy var newUser : RegisterInteractorUser = PFUser()
        
        // MARK: - Operational
        func signUpFailed(_ error: NSError?) {
                presenter.signUpFailure(error)
        }
        
        func signUpSucceeded() {
                presenter.signUpSuccess()
        }
        
        // MARK: - Interactor Input
        func registerUser(_ username: String, password: String) {
                newUser.username = username
                newUser.password = password
                
                newUser.signUpInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                                self.signUpSucceeded()
                        } else {
                                self.signUpFailed(error as NSError?)
                        }
                }
        }
}
