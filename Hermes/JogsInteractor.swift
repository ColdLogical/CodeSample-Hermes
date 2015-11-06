//
//  JogsInteractor.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse

extension PFQuery : JogsInteractorRoleQuery { }
extension PFUser : JogsInteractorUserService { }

class JogsInteractor: NSObject, JogsInteractorInput {
        // MARK: - VIPER Stack
        lazy var presenter : JogsInteractorOutput = JogsPresenter()
        lazy var roleQuery : JogsInteractorRoleQuery? = PFRole.query()
        lazy var userService : JogsInteractorUserService.Type = PFUser.self
        
        // MARK: - Instance Variables
        
        // MARK: - Operational
        func failedDeletingJog(error: NSError?) {
                presenter.failedDeletingJog()
        }
        
        func failedFetchingJogs(error: NSError?) {
                presenter.failedFetchingJogs()
        }
        
        func successDeletingJog() {
                presenter.deletedJog()
        }
        
        func successFetchingJogs(jogs: [Jog]) {
                presenter.fetchedJogs(jogs)
        }
        
        // MARK: - Interactor Input
        func deleteJog(jog: Jog) {
                jog.deleteInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                                self.successDeletingJog()
                        } else {
                                self.failedDeletingJog(error)
                        }
                }
        }
        
        func fetchCurrentUser() {
                if let currentUser = userService.currentUser() {
                        if let rq = roleQuery {
                                rq.whereKey("name", equalTo:"Admin")
                                rq.whereKey("users", equalTo:currentUser)
                                rq.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
                                        if object != nil {
                                                self.presenter.fetchedCurrentUser(currentUser, isAdmin: true)
                                        } else {
                                                self.presenter.fetchedCurrentUser(currentUser, isAdmin: false)
                                        }
                                })
                        } else {
                                presenter.failedFetchingCurrentUser()
                        }
                } else {
                        presenter.failedFetchingCurrentUser()
                }
        }
        
        func fetchJogs(user: PFUser?) {
                let query = PFQuery(className: "Jog")
                
                if let u = user {
                        query.whereKey("user", equalTo: u)
                }
                
                query.findObjectsInBackgroundWithBlock { (jogs, error) -> Void in
                        if let j = jogs as? [Jog] {
                                self.successFetchingJogs(j)
                        } else {
                                if let e = error {
                                        self.failedFetchingJogs(e)
                                }
                        }
                }
        }
        
        func logout() {
                userService.logOut()
        }
}