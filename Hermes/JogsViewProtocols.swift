//
//  JogsViewProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

// VIPER Interface for communication from Presenter -> View
protocol JogsViewInterface : class {
        func showDeleteJogFailed()
        func showFetchingJogsFailed()
        func showJogs(_ jogs: [Jog])
}
