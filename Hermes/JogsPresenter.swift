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
        
        // MARK: - Operational
        
        // MARK: - Interactor Output
        func failedFetchingCurrentUser() {
                wireframe.presentLogin()
        }
        
        func fetchedCurrentUser(currentUser: PFUser) {
                
        }
        
        // MARK: - Presenter Interface
        func userTappedAdd() {
                wireframe.presentAddJog()
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
