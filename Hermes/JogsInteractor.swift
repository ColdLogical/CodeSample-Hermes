//
//  JogsInteractor.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse

extension PFUser : JogsInteractorUserService { }

class JogsInteractor: NSObject, JogsInteractorInput {
        // MARK: - VIPER Stack
        lazy var presenter : JogsInteractorOutput = JogsPresenter()
        lazy var userService : JogsInteractorUserService.Type = PFUser.self
        
        // MARK: - Instance Variables
        
        // MARK: - Operational
        
        // MARK: - Interactor Input
        func fetchCurrentUser() {
                if let currentUser = userService.currentUser() {
                        presenter.fetchedCurrentUser(currentUser)
                } else {
                        presenter.failedFetchingCurrentUser()
                }
        }
        
        func logout() {
                userService.logOut()
        }
}