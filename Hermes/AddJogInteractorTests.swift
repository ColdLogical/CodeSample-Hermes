//
//  AddJogInteractorTests.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Hermes

class AddJogInteractorTests: XCTestCase, AddJogInteractorOutput {
        var interactor = AddJogInteractor()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                interactor = AddJogInteractor()
                interactor.presenter = self
        }
        
        override func tearDown() {
                super.tearDown()
		interactor = AddJogInteractor()
                expectation = nil;
        }
        
        // MARK: - Operational

        // MARK: - Interactor Input

        // MARK: - Interactor Output
        
}
