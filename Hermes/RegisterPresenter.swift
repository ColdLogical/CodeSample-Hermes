//
//  RegisterPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

class RegisterPresenter : NSObject, RegisterInteractorOutput, RegisterPresenterInterface, RegisterRouting {
        // MARK: - VIPER Stack
        lazy var interactor : RegisterInteractorInput = RegisterInteractor()
        lazy var view : RegisterViewInterface = RegisterView()
        lazy var wireframe : RegisterWireframeInterface = RegisterWireframe()
        
        // MARK: - Instance Variables
        
        // MARK: - Operational
        
        // MARK: - Interactor Output
        func signUpFailure(_ error: NSError?) {
                view.showMessage("Failed to register... Try again please")
        }
        
        func signUpSuccess() {
                wireframe.registrationFinished()
        }
        
        // MARK: - Presenter Interface
        func userTappedRegister(_ username: String, password: String) {
                view.showMessage("Registering...")
                interactor.registerUser(username, password: password)
        }
        
        // MARK: - Routing
        func presenting() {
                view.showMessage("")
        }
}
