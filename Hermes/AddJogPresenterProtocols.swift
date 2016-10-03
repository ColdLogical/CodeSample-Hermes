//
//  AddJogPresenterProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

// VIPER Interface for communication from Interactor -> Presenter
protocol AddJogInteractorOutput : class {
        func savedJog()
        func saveJogFailed()
}

// VIPER Interface for communication from View -> Presenter
protocol AddJogPresenterInterface : class {
        func userTappedCancel()
        func userTappedSave(_ jog: Jog?, distance: String, date: Date, time: TimeInterval)
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol AddJogRouting : class {
        func presentingJog(_ jog: Jog)
}
