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

class AddJogWireframeTests: XCTestCase, AddJogDelegate, AddJogRouting, AddJogModalViewController, AddJogNavigation {
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
                XCTAssertTrue (wireframe.moduleInteractor.isKind(of: AddJogInteractor.self), "Lazily loader should create an instance of AddJogInteractor")
        }

        func testAddJogPresenterLazyLoaderWithNilValueShouldInstantiatePresenter() {
                XCTAssertNotNil (wireframe.modulePresenter, "Lazy loader should create a new presenter if it doesnt exist")
                XCTAssertTrue (wireframe.modulePresenter.isKind(of: AddJogPresenter.self), "Lazily loader should create an instance of AddJogPresenter")
        }

        func testAddJogViewLazyLoaderWithNilValueShouldInstantiateView() {
                XCTAssertNotNil (wireframe.moduleView, "Lazy loader should create a new view if it doesnt exist")
                XCTAssertTrue (wireframe.moduleView.isKind(of: AddJogView.self), "Lazily loader should create an instance of AddJogView")
        }

        func testStoryboardWithNothingShouldReturnStoryboardWithkAddJogStoryboardIdentifier() {
                let storyboard = AddJogWireframe.storyboard()
                
                XCTAssertEqual (kAddJogStoryboardIdentifier, storyboard.value(forKey: "name") as! String?, "Storyboard identifier should be the constant identifier defined in the AddJogWireframeProtocols file")
        }

        // MARK: - Operational
        
        // MARK: - Module Interface
        func testDismissWithAnythingShouldTellViewToDismissViewControllerAnimatedTrueCompletionNil() {
                expectation = self.expectation(withDescription: "View dismiss view controller from dismiss")
                
                wireframe.view = self
                
                wireframe.dismiss()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to dismiss view controller")
                        }
                }
        }
        
        func testPresentModallyOnViewControllerWithNonNilJogShouldCallPresenterPresentingJog() {
                expectation = self.expectation(withDescription: "Presenter presenting jog from present modally on view controller")
                
                let jog = Jog()
                jog.distance = 314159
                
                wireframe.presentModallyOnViewController(self, jog: jog)
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told presenting jog")
                        }
                }
        }
        
        func testPresentModallyOnViewControllerWithNonNilViewControllerShouldCallPresentViewControllerAnimatedTrueCompletionNil() {
                expectation = self.expectation(withDescription: "View controller present view controller from present modally on view controller")
                
                wireframe.presentModallyOnViewController(self, jog: nil)
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View Controller never told to present modally")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func testAddJogFinishedWithNonNilDelegateShouldTellDelegateAddJogCompleted() {
                expectation = self.expectation(withDescription: "Delegate add jog completed from add jog finished")
                
                wireframe.addJogFinished()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Delegate never told that add jog finished")
                        }
                }
        }
        
        func testCancelAddJogWithNonNilDelegateShouldTellDelegateAddJogCancelled() {
                expectation = self.expectation(withDescription: "Delegate add jog cancelled from cancel add jog")
                
                wireframe.cancelAddJog()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Delegate never told add jog was cancelled")
                        }
                }
        }
        
        // MARK: - Delegate
        func addJogComplete(_ addJogModule: AddJogModuleInterface) {
                if let exp = expectation {
                        if exp.description == "Delegate add jog completed from add jog finished" {
                                exp.fulfill()
                                
                                XCTAssert(addJogModule === wireframe ? true : false, "Module should be the wireframe")
                        }
                }
        }
        
        func addJogCancelled(_ addJogModule: AddJogModuleInterface) {
                if let exp = expectation {
                        if exp.description == "Delegate add jog cancelled from cancel add jog" {
                                exp.fulfill()
                                
                                XCTAssert(addJogModule === wireframe ? true : false, "Module should be the wireframe")
                        }
                }
        }
        
        // MARK: - Routing
        func presentingJog(_ jog: Jog) {
                if let exp = expectation {
                        if exp.description == "Presenter presenting jog from present modally on view controller" {
                                exp.fulfill()
                                
                                XCTAssertEqual(314159, jog.distance, "Jog distance should be 314159")
                        }
                }
        }
        
        // MARK: - Add Jog Modal View Controller
        func presentViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
                if let exp = expectation {
                        if exp.description == "View controller present view controller from present modally on view controller" {
                                exp.fulfill()
                                
                                XCTAssert(viewControllerToPresent === wireframe.moduleNavigationController ? true : false, "View controller to present should be the add jog navigation controller")
                                XCTAssertTrue(flag, "Animated should be true")
                                XCTAssertNil(completion, "Completion block should be nil")
                        }
                }
        }
        
        // MARK: - Add Jog Navigation
        func dismissViewControllerAnimated(_ flag: Bool, completion: (() -> Void)?) {
                if let exp = expectation {
                        if exp.description == "View dismiss view controller from dismiss" {
                                exp.fulfill()
                                
                                XCTAssertTrue(flag, "Animated should be true")
                                XCTAssertNil(completion, "Completion block should be nil")
                        }
                }
        }
}
