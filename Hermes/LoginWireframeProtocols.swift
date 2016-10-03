//
//  LoginWireframeProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

// VIPER Module Constants
let kLoginNavigationControllerIdentifier = "LoginNavigationController"
let kLoginStoryboardIdentifier = "Login"
let kLoginViewIdentifier = "LoginView"

// VIPER Interface to the Module
protocol LoginDelegate : class {
        func loginCompleted(_ loginModule: LoginModuleInterface)
}

// Interface Abstraction for working with the VIPER Module
protocol LoginModuleInterface : class {
        func dismiss()
        func presentModallyOnViewController(_ viewControllor: LoginModalViewController)
}

// VIPER Interface for manipulating the navigation
protocol LoginNavigation: class {
        func dismissViewControllerAnimated(_ flag: Bool, completion: (() -> Void)?)
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol LoginWireframeInterface : class {
        func loginFinished()
        func presentRegister()
}

protocol LoginModalViewController : class {
        func presentViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}
