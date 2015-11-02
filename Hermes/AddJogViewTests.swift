//
//  AddJogViewTests.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class AddJogViewTests: XCTestCase, AddJogPresenterInterface {
        var view = AddJogView()
	var window = UIWindow()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()

                let sb = UIStoryboard(name: kAddJogStoryboardIdentifier, bundle: NSBundle(forClass: AddJogView.self))
                view = sb.instantiateViewControllerWithIdentifier(kAddJogViewIdentifier) as! AddJogView
		view.loadView()
                view.presenter = self

		window.rootViewController = view
		window.makeKeyAndVisible()
        }
        
        override func tearDown() {
                super.tearDown()
		view = AddJogView()
		window = UIWindow()
                expectation = nil
        }
        
        // MARK: - Operational

        // MARK: - View Interface

        // MARK: - Presenter Interface
        
}
