//
//  AddJogPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

class AddJogPresenter : NSObject, AddJogInteractorOutput, AddJogPresenterInterface, AddJogRouting {
        // MARK: - VIPER Stack
        lazy var interactor : AddJogInteractorInput = AddJogInteractor()
        lazy var view : AddJogViewInterface = AddJogView()
        lazy var wireframe : AddJogWireframeInterface = AddJogWireframe()
        
        // MARK: - Instance Variables
        
        // MARK: - Operational
        
        // MARK: - Interactor Output
        
        // MARK: - Presenter Interface
        
        // MARK: - Routing
        
}
