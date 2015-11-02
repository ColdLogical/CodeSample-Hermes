//
//  AddJogWireframeProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

// VIPER Module Constants
let kAddJogNavigationControllerIdentifier = "AddJogNavigationController"
let kAddJogStoryboardIdentifier = "AddJog"
let kAddJogViewIdentifier = "AddJogView"

// VIPER Interface to the Module
protocol AddJogDelegate : class {
        
}

// Interface Abstraction for working with the VIPER Module
protocol AddJogModuleInterface : class {
        func dismiss()
        func presentModallyOnViewController(viewController: AddJogModalViewController)
}

// VIPER Interface for manipulating the navigation
protocol AddJogNavigation: class {
        
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol AddJogWireframeInterface : class {
        
}

protocol AddJogModalViewController : class {
        func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}