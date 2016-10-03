//
//  RegisterInteractorProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Parse

// VIPER Interface for communication from Presenter to Interactor
protocol RegisterInteractorInput : class {
        func registerUser(_ username: String, password: String)
}

protocol RegisterInteractorUser : class {
        func signUpInBackgroundWithBlock(_ block: PFBooleanResultBlock?)
        
        var password : String? { get set }
        var username : String? { get set }
}
