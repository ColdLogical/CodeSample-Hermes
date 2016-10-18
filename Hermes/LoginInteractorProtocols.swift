//
//  LoginInteractorProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Parse

// VIPER Interface for communication from Presenter to Interactor
protocol LoginPresenterToInteractorInterface : class {
        func login(_ username: String, password: String)
}

protocol LoginInteractorUser {
        static func logInWithUsernameInBackground(_ username: String, password: String, block: PFUserResultBlock?)
}
