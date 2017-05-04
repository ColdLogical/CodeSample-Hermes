//
//  LoginPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

class LoginPresenter: NSObject, LoginInteractorToPresenterInterface, LoginViewToPresenterInterface, LoginWireframeToPresenterInterface {
        // MARK: - VIPER Stack
        lazy var interactor: LoginPresenterToInteractorInterface = LoginInteractor()
        lazy var view: LoginPresenterToViewInterface = LoginView()
        lazy var wireframe: LoginPresenterToWireframeInterface = LoginWireframe()

        // MARK: - Instance Variables

        // MARK: - Operational

        // MARK: - Interactor Output
        func failedLogin(_ error: NSError?) {
                view.showMessage("Login failed. Please try again.")
        }

        func loginSuccess() {
                wireframe.loginFinished()
        }

        // MARK: - Presenter Interface
        func userTappedLogin(_ username: String, password: String) {
                view.showMessage("Logging In...")
                interactor.login(withUsername: username, andPassword: password)
        }

        func userTappedRegister() {
                wireframe.presentRegister()
        }

        // MARK: - WireframeToPresenterInterface

}
