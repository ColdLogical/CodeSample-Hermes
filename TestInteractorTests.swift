//
//  TestInteractorTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Hermes

class TestInteractorTests: XCTestCase
        , TestInteractorToPresenterInterface
        {
        var interactor = TestInteractor()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                
                interactor = TestInteractor()
                
                interactor.presenter = self
        }
        
        override func tearDown() {
                super.tearDown()
                expectation = nil;
        }
        
        // MARK: - Operational

        // MARK: - Presenter to Interactor Interface

        // MARK: - Interactor to Presenter Interface
        
}
