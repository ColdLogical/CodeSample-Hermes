//
//  JogsPresenterProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

// VIPER Interface for communication from Interactor -> Presenter
protocol JogsInteractorToPresenterInterface : class {
        func failedDeletingJog()
        func failedFetchingCurrentUser()
        func failedFetchingJogs()
        func deletedJog()
        func fetched(user: User)
        func fetched(jogs: [Jog])
}

// VIPER Interface for communication from View -> Presenter
protocol JogsViewToPresenterInterface : class {
        func userTappedAdd()
        func userTappedDelete(onJog: Jog)
        func userTapped(onJog: Jog)
        func userTappedLogout()
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol JogsWireframeToPresenterInterface : class {
        func presentingJogs()
}
