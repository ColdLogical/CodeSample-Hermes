//
//  TestPresenterProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

// VIPER Interface to the Module
protocol TestDelegate : class {
        
}

// VIPER Interface for communication from Interactor -> Presenter
protocol TestInteractorToPresenterInterface : class {
        
}

// VIPER Interface for communication from View -> Presenter
protocol TestViewToPresenterInterface : class {
        
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol TestWireframeToPresenterInterface : class {
        weak var delegate: TestDelegate? { get }
        func set(newDelegate: TestDelegate?)
}
