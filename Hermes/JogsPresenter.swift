//
//  JogsPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse

class JogsPresenter : NSObject, JogsInteractorOutput, JogsPresenterInterface, JogsRouting {
        // MARK: - VIPER Stack
        lazy var interactor : JogsInteractorInput = JogsInteractor()
        lazy var view : JogsViewInterface = JogsView()
        lazy var wireframe : JogsWireframeInterface = JogsWireframe()
        
        // MARK: - Instance Variables
        var currentUser: PFUser?
        var currentUserIsAdmin: Bool = false
        
        // MARK: - Operational
        func fetchJogsBasedOnAdminStatus() {
                if currentUser != nil {
                        if currentUserIsAdmin {
                                self.interactor.fetchJogs(nil)
                        } else {
                                self.interactor.fetchJogs(currentUser)
                        }
                }
        }
        
        // MARK: - Interactor Output
        func deletedJog() {
                fetchJogsBasedOnAdminStatus()
        }
        
        func failedDeletingJog() {
                view.showDeleteJogFailed()
        }
        
        func failedFetchingCurrentUser() {
                wireframe.presentLogin()
        }
        
        func failedFetchingJogs() {
                view.showFetchingJogsFailed()
        }
        
        func fetchedCurrentUser(_ currentUser: PFUser, isAdmin: Bool) {
                self.currentUser = currentUser
                currentUserIsAdmin = isAdmin
                fetchJogsBasedOnAdminStatus()
        }
        
        func fetchedJogs(_ jogs: [Jog]) {
                view.showJogs(jogs)
        }
        
        // MARK: - Presenter Interface
        func userTappedAdd() {
                wireframe.presentAddJog(nil)
        }
        
        func userTappedDelete(_ jog: Jog) {
                interactor.deleteJog(jog)
        }
        
        func userTappedJog(_ jog: Jog) {
                wireframe.presentAddJog(jog)
        }
        
        func userTappedLogout() {
                interactor.logout()
                wireframe.presentLogin()
        }
        
        // MARK: - Routing
        func presentingJogs() {
                interactor.fetchCurrentUser()
        }
}
