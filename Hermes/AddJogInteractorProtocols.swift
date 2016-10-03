//
//  AddJogInteractorProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

// VIPER Interface for communication from Presenter to Interactor
protocol AddJogInteractorInput : class {
        func saveJog(_ jog: Jog)
}
