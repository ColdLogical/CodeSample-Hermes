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
        func addJogComplete(_ addJogModule: AddJogModuleInterface)
        func addJogCancelled(_ addJogModule: AddJogModuleInterface)
}

// Interface Abstraction for working with the VIPER Module
protocol AddJogModuleInterface : class {
        func dismiss()
        func presentModallyOnViewController(_ viewController: AddJogModalViewController, jog: Jog?)
}

// VIPER Interface for manipulating the navigation
protocol AddJogNavigation: class {
        func dismissViewControllerAnimated(_ flag: Bool, completion: (() -> Void)?)
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol AddJogPresenterToWireframeInterface : class {
        func addJogFinished()
        func cancelAddJog()
}

protocol AddJogModalViewController : class {
        func presentViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}
