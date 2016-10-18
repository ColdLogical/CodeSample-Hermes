//
//  TestWireframeProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

// VIPER Module Constants
// Uncomment to utilize a navigation contoller from storyboard
//let kTestNavigationControllerIdentifier = "TestNavigationController"
let kTestStoryboardIdentifier = "Test"
let kTestViewIdentifier = "TestView"

// Interface Abstraction for working with the VIPER Module
protocol TestModuleInterface : class {
        var delegate: TestDelegate? { get set }
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol TestPresenterToWireframeInterface : class {
        
}
