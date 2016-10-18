//
//  TestPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Hermes

class TestPresenterTests: XCTestCase
        , TestDelegate
        , TestPresenterToInteractorInterface
        , TestPresenterToViewInterface
        , TestPresenterToWireframeInterface
        {
        var presenter = TestPresenter()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                
                presenter = TestPresenter()
                
                presenter.interactor = self
                presenter.view = self
                presenter.wireframe = self
        }
        
        override func tearDown() {
                super.tearDown()
                expectation = nil;
        }
        
        // MARK: - Operational

        // MARK: - Interactor to Presenter Interface

        // MARK: - View to Presenter Interface

        // MARK: - Wireframe to Presenter Interface
        func testSetDelegateWithAnythingShouldSetPresentersDelegate() {
                presenter.set(newDelegate: self)
                
                XCTAssert(presenter.delegate === self)
        }

        // MARK: - Presenter to Interactor Interface
        
        // MARK: - Presenter to View Interface
        
        // MARK: - Presenter to Wireframe Interface
        
}
