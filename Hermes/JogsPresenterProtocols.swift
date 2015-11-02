//
//  JogsPresenterProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Parse

// VIPER Interface for communication from Interactor -> Presenter
protocol JogsInteractorOutput : class {
        func failedFetchingCurrentUser()
        func fetchedCurrentUser(currentUser: PFUser)
}

// VIPER Interface for communication from View -> Presenter
protocol JogsPresenterInterface : class {
        func userTappedAdd()
        func userTappedLogout()
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol JogsRouting : class {
        func presentingJogs()
}