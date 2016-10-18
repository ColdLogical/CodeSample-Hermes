//
//  TestViewTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class TestViewTests: XCTestCase
        , TestViewToPresenterInterface
        {
        var view = TestView()
	var window = UIWindow()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()

                _ = view.view
                
                view.presenter = self
        }
        
        override func tearDown() {
                super.tearDown()
                expectation = nil
        }
        
        // MARK: - Operational

        // MARK: - Presenter to View Interface

        // MARK: - View to Presenter Interface
        
}
