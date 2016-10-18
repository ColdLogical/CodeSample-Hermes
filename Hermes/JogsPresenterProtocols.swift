//
//  JogsPresenterProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Parse

// VIPER Interface for communication from Interactor -> Presenter
protocol JogsInteractorToPresenterInterface : class {
        func failedDeletingJog()
        func failedFetchingCurrentUser()
        func failedFetchingJogs()
        func deletedJog()
        func fetchedCurrentUser(_ currentUser: PFUser, isAdmin: Bool)
        func fetchedJogs(_ jogs: [Jog])
}

// VIPER Interface for communication from View -> Presenter
protocol JogsViewToPresenterInterface : class {
        func userTappedAdd()
        func userTappedDelete(_ jog: Jog)
        func userTappedJog(_ jog: Jog)
        func userTappedLogout()
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol JogsWireframeToPresenterInterface : class {
        func presentingJogs()
}
