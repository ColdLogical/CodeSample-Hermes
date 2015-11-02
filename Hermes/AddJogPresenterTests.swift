//
//  AddJogPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Hermes

class AddJogPresenterTests: XCTestCase, AddJogInteractorInput, AddJogViewInterface, AddJogWireframeInterface {
        var presenter = AddJogPresenter()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                presenter = AddJogPresenter()
                presenter.interactor = self
                presenter.view = self
                presenter.wireframe = self
        }
        
        override func tearDown() {
                super.tearDown()
		presenter = AddJogPresenter()
                expectation = nil;
        }
        
        // MARK: - Operational

        // MARK: - Interactor Output

        // MARK: - Presenter Interface

        // MARK: - Routing

        // MARK: - Interactor Input
        
        // MARK: - View Interface
        
        // MARK: - Wireframe Interface
        
}
