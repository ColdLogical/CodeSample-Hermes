//
//  TestWireframeTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class TestWireframeTests: XCTestCase
        , TestDelegate
        , TestWireframeToPresenterInterface
        {
        var wireframe = TestWireframe()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                
		wireframe = TestWireframe()
                
                wireframe.presenter = self;
        }
        
        override func tearDown() {
                super.tearDown()
                expectation = nil;
        }
        
        // MARK: - Init
        func testInitWithNothingShouldInstantiateVIPERStackAndConnectLayers() {
                wireframe = TestWireframe()
                
                XCTAssertNotNil(wireframe, "Wireframe cannot be nil after init")
                
                XCTAssertNotNil(wireframe.moduleInteractor, "Interactor cannot be nil after init")
                XCTAssertNotNil(wireframe.modulePresenter, "Presenter cannot be nil after init")
                XCTAssertNotNil(wireframe.moduleView, "View cannot be nil after init")
                
                XCTAssert (wireframe.modulePresenter === wireframe.moduleInteractor.presenter ? true : false, "Interactor's presenter must be the module's presenter")
                
                XCTAssert(wireframe.moduleInteractor === wireframe.modulePresenter.interactor ? true : false, "Presenter's interactor must be the module's interactor")
                XCTAssert(wireframe.moduleView === wireframe.modulePresenter.view ? true : false, "Presenter's view must be the module's view")
                XCTAssert(wireframe === wireframe.modulePresenter.wireframe ? true : false, "Presenter's wireframe must be the module'swireframe")
                
                XCTAssert(wireframe.modulePresenter === wireframe.moduleView.presenter ? true : false, "View's presenter must be the module's presenter")
                
                XCTAssert(wireframe.presenter === wireframe.modulePresenter ? true : false, "Wireframe's presenter must be the module's presenter")
        }
        
        // MARK: - Lazy Loaders
        func testTestInteractorLazyLoaderWithNilValueShouldInstantiateInteractor() {
                XCTAssertNotNil (wireframe.moduleInteractor, "Lazy loader should create a new interactor if it doesnt exist")
                XCTAssertTrue ((wireframe.moduleInteractor as Any) is TestInteractor, "Lazy loader should create an instance of TestInteractor")
        }

        func testTestPresenterLazyLoaderWithNilValueShouldInstantiatePresenter() {
                XCTAssertNotNil (wireframe.modulePresenter, "Lazy loader should create a new presenter if it doesnt exist")
                XCTAssertTrue ((wireframe.modulePresenter as Any) is TestPresenter, "Lazy loader should create an instance of TestPresenter")
        }

        func testTestViewLazyLoaderWithNilValueShouldInstantiateView() {
                XCTAssertNotNil (wireframe.moduleView, "Lazy loader should create a new view if it doesnt exist")
                XCTAssertTrue ((wireframe.moduleView as Any) is TestView, "Lazy loader should create an instance of TestView")
        }

        func testStoryboardWithNothingShouldReturnStoryboardWithkTestStoryboardIdentifier() {
                let storyboard = TestWireframe.storyboard()
                
                XCTAssertEqual (kTestStoryboardIdentifier, storyboard.value(forKey: "name") as! String?, "Storyboard identifier should be the constant identifier defined in the TestWireframeProtocols file")
        }

        // MARK: - Operational
        func testGetDelegateWithSelfAsDelegateShouldAskPresenterForDelegate() {
                expectation = expectation(description: "Presenter get delegate from delegate accessor")
                
                let delegate = wireframe.delegate
                
                XCTAssert(delegate === self)
                
                waitForExpectations(timeout: 5, handler: {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never asked for delegate")
                        }
                })
        }
        
        func testSetDelegateWithAnythingShouldTellPresenterToSetNewDelegate() {
                expectation = expectation(description: "Presenter set new delegate from delegate modifier")
                
                wireframe.delegate = self
                
                waitForExpectations(timeout: 5, handler: {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter was never told to set delegate")
                        }
                })
        }
        
        // MARK: - Module Interface
        
        // MARK: - Presenter to Wireframe Interface
        
        // MARK: - Delegate
        
        // MARK: - Wireframe to Presenter Interface
        weak var delegate: TestDelegate? {
                get {
                        if expectation?.description ==  "Presenter get delegate from delegate accessor" {
                                expectation?.fulfill()
                        }
                        return self
                }
        }
        
        func set(newDelegate: TestDelegate?) {
                if expectation?.description ==  "Presenter set new delegate from delegate modifier" {
                        expectation?.fulfill()
                        XCTAssert(newDelegate === self)
                }
        }
}
