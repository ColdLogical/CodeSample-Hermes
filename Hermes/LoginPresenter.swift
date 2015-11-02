//
//  LoginPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

class LoginPresenter : NSObject, LoginInteractorOutput, LoginPresenterInterface, LoginRouting {
        // MARK: - VIPER Stack
        lazy var interactor : LoginInteractorInput = LoginInteractor()
        lazy var view : LoginViewInterface = LoginView()
        lazy var wireframe : LoginWireframeInterface = LoginWireframe()
        
        // MARK: - Instance Variables
        
        // MARK: - Operational
        
        // MARK: - Interactor Output
        func failedLogin(error: NSError?) {
                view.showMessage("Login failed. Please try again.")
        }
        
        func loginSuccess() {
                wireframe.loginFinished()
        }
        
        // MARK: - Presenter Interface
        func userTappedLogin(username: String, password: String) {
                view.showMessage("Logging In...")
                interactor.login(username, password: password)
        }
        
        func userTappedRegister() {
                wireframe.presentRegister()
        }
        
        // MARK: - Routing
        
}
