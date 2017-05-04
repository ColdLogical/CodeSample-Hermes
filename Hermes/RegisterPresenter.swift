//
//  RegisterPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

class RegisterPresenter: RegisterInteractorToPresenterInterface, RegisterViewToPresenterInterface, RegisterWireframeToPresenterInterface {
        // MARK: - VIPER Stack
        lazy var interactor: RegisterPresenterToInteractorInterface = RegisterInteractor()
        lazy var view: RegisterPresenterToViewInterface = RegisterView()
        lazy var wireframe: RegisterPresenterToWireframeInterface = RegisterWireframe()

        // MARK: - Instance Variables

        // MARK: - Operational

        // MARK: - Interactor Output
        func signUpFailure(withError error: Error) {
                view.show(message: "Failed to register... Try again please")
        }

        func signUpSuccess() {
                wireframe.registrationFinished()
        }

        // MARK: - Presenter Interface
        func userTappedRegister(withUsername username: String, andPassword password: String) {
                view.show(message: "Registering...")
                interactor.register(withUsername: username, andPassword: password)
        }

        // MARK: - WireframeToPresenterInterface
        func presenting() {
                view.show(message: "")
        }
}
