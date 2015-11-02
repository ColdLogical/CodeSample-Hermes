//
//  AddJogWireframeTests.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class AddJogWireframeTests: XCTestCase, AddJogDelegate, AddJogRouting, AddJogModalViewController {
        var wireframe = AddJogWireframe()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                wireframe.delegate = self;
                wireframe.presenter = self;
        }
        
        override func tearDown() {
                super.tearDown()
		wireframe = AddJogWireframe()
                expectation = nil;
        }
        
        // MARK: - Init
        func testInitWithNothingShouldInstantiateVIPERStackAndConnectLayers() {
                wireframe = AddJogWireframe()
                
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
        func testAddJogInteractorLazyLoaderWithNilValueShouldInstantiateInteractor() {
                XCTAssertNotNil (wireframe.moduleInteractor, "Lazy loader should create a new interactor if it doesnt exist")
                XCTAssertTrue (wireframe.moduleInteractor.isKindOfClass(AddJogInteractor), "Lazily loader should create an instance of AddJogInteractor")
        }

        func testAddJogPresenterLazyLoaderWithNilValueShouldInstantiatePresenter() {
                XCTAssertNotNil (wireframe.modulePresenter, "Lazy loader should create a new presenter if it doesnt exist")
                XCTAssertTrue (wireframe.modulePresenter.isKindOfClass(AddJogPresenter), "Lazily loader should create an instance of AddJogPresenter")
        }

        func testAddJogViewLazyLoaderWithNilValueShouldInstantiateView() {
                XCTAssertNotNil (wireframe.moduleView, "Lazy loader should create a new view if it doesnt exist")
                XCTAssertTrue (wireframe.moduleView.isKindOfClass(AddJogView), "Lazily loader should create an instance of AddJogView")
        }

        func testStoryboardWithNothingShouldReturnStoryboardWithkAddJogStoryboardIdentifier() {
                let storyboard = AddJogWireframe.storyboard()
                
                XCTAssertEqual (kAddJogStoryboardIdentifier, storyboard.valueForKey("name") as! String?, "Storyboard identifier should be the constant identifier defined in the AddJogWireframeProtocols file")
        }

        // MARK: - Operational
        
        // MARK: - Module Interface
        func testPresentModallyOnViewControllerWithNonNilViewControllerShouldCallPresentViewControllerAnimatedTrueCompletionNil() {
                expectation = expectationWithDescription("View controller present view controller from present modally on view controller")
                
                wireframe.presentModallyOnViewController(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("<#Message#>")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        
        // MARK: - Delegate
        
        // MARK: - Routing
        
        // MARK: - Add Jog Modal View Controller
        func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
                if let exp = expectation {
                        if exp.description == "View controller present view controller from present modally on view controller" {
                                exp.fulfill()
                                
                                XCTAssert(viewControllerToPresent === wireframe.moduleNavigationController ? true : false, "View controller to present should be the add jog navigation controller")
                                XCTAssertTrue(flag, "Animated should be true")
                                XCTAssertNil(completion, "Completion block should be nil")
                        }
                }
        }
}
