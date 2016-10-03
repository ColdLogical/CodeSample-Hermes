//
//  AddJogViewProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

// VIPER Interface for communication from Presenter -> View
protocol AddJogViewInterface : class {
        func showJog(_ jog: Jog)
        func showSaveJogFailed()
}
