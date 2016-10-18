//
//  LoginPresenterProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

// VIPER Interface for communication from Interactor -> Presenter
protocol LoginInteractorToPresenterInterface : class {
        func failedLogin(_ error: NSError?)
        func loginSuccess()
}

// VIPER Interface for communication from View -> Presenter
protocol LoginViewToPresenterInterface : class {
        func userTappedLogin(_ username: String, password: String)
        func userTappedRegister()
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol LoginWireframeToPresenterInterface : class {
        
}
