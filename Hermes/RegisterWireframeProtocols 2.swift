//
//  RegisterWireframeProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

// VIPER Module Constants
let kRegisterStoryboardIdentifier = "Register"
let kRegisterViewIdentifier = "RegisterView"

// VIPER Interface to the Module
protocol RegisterDelegate : class {
        func registrationCompleted(_ registrationModule: RegisterModuleInterface)
}

// Interface Abstraction for working with the VIPER Module
protocol RegisterModuleInterface : class {
        func popViewFromNavigationController(_ navigationController: RegisterNavigationController)
        func pushOnNavigationController(_ viewControllor: RegisterNavigationController)
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol RegisterPresenterToWireframeInterface : class {
        func registrationFinished()
}

protocol RegisterNavigationController : class {
        func popViewControllerAnimated(_ animated: Bool) -> UIViewController?
        func pushViewController(_ viewController: UIViewController, animated: Bool)
}
