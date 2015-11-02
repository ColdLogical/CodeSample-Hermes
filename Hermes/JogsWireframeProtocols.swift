//
//  JogsWireframeProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

// VIPER Module Constants
let kJogsNavigationControllerIdentifier = "JogsNavigationController"
let kJogsStoryboardIdentifier = "Jogs"
let kJogsViewIdentifier = "JogsView"

// VIPER Interface to the Module
protocol JogsDelegate : class {
        
}

// Interface Abstraction for working with the VIPER Module
protocol JogsModuleInterface : class {
        func presentInWindow(window: JogsWindow)
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol JogsWireframeInterface : class {
        func presentAddJog()
        func presentLogin()
}

protocol JogsWindow : class {
        var rootViewController : UIViewController? { get set }
}