//
//  JogsInteractorProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Parse

// VIPER Interface for communication from Presenter to Interactor
protocol JogsInteractorInput : class {
        func fetchCurrentUser()
        func logout()
}

protocol JogsInteractorUserService {
        static func currentUser() -> PFUser?
        static func logOut()
}