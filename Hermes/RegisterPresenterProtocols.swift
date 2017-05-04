//
//  RegisterPresenterProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

// VIPER Interface for communication from Interactor -> Presenter
protocol RegisterInteractorToPresenterInterface : class {
        func signUpFailure(withError error: Error)
        func signUpSuccess()
}

// VIPER Interface for communication from View -> Presenter
protocol RegisterViewToPresenterInterface : class {
        func userTappedRegister(withUsername username: String, andPassword password: String)
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol RegisterWireframeToPresenterInterface : class {
        func presenting()
}
