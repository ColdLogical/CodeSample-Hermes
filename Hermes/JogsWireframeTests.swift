//
//  JogsWireframeTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class JogsWireframeTests: XCTestCase,
        JogsDelegate, JogsRouting, JogsWindow,
        LoginModuleInterface, AddJogModuleInterface {
        var wireframe = JogsWireframe()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                wireframe.delegate = self;
                wireframe.presenter = self;
        }
        
        override func tearDown() {
                super.tearDown()
		wireframe = JogsWireframe()
                expectation = nil;
        }
        
        // MARK: - Init
        func testInitWithNothingShouldInstantiateVIPERStackAndConnectLayers() {
                wireframe = JogsWireframe()
                
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
        func testJogsInteractorLazyLoaderWithNilValueShouldInstantiateInteractor() {
                XCTAssertNotNil (wireframe.moduleInteractor, "Lazy loader should create a new interactor if it doesnt exist")
                XCTAssertTrue (wireframe.moduleInteractor.isKindOfClass(JogsInteractor), "Lazily loader should create an instance of JogsInteractor")
        }

        func testJogsPresenterLazyLoaderWithNilValueShouldInstantiatePresenter() {
                XCTAssertNotNil (wireframe.modulePresenter, "Lazy loader should create a new presenter if it doesnt exist")
                XCTAssertTrue (wireframe.modulePresenter.isKindOfClass(JogsPresenter), "Lazily loader should create an instance of JogsPresenter")
        }

        func testJogsViewLazyLoaderWithNilValueShouldInstantiateView() {
                XCTAssertNotNil (wireframe.moduleView, "Lazy loader should create a new view if it doesnt exist")
                XCTAssertTrue (wireframe.moduleView.isKindOfClass(JogsView), "Lazily loader should create an instance of JogsView")
        }

        func testStoryboardWithNothingShouldReturnStoryboardWithkJogsStoryboardIdentifier() {
                let storyboard = JogsWireframe.storyboard()
                
                XCTAssertEqual (kJogsStoryboardIdentifier, storyboard.valueForKey("name") as? String, "Storyboard identifier should be the constant identifier defined in the JogsWireframeProtocols file")
        }

        // MARK: - Operational
        func testPresentInWindowWithNonNilWindowShouldSetRootViewControllerToModuleNavigationController() {
                expectation = expectationWithDescription("Window set root view controller to module navigation controller")
                
                wireframe.presentInWindow(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Window's root view controller was not set to the module navigation controller")
                        }
                }
        }
        
        func testPresentInWindowWithAnythingShouldTellPresenterPresentingJogs() {
                expectation = expectationWithDescription("Presenter told presenting jogs from wireframe present in window")
                
                wireframe.presentInWindow(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told the module is presenting jogs")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func testPresentAddJogWithAnythingShouldCallAddJogModulePresentModallyOnViewController() {
                expectation = expectationWithDescription("Add jog module present modally on view controller from present add jog")
                
                wireframe._addJogModule = self
                
                wireframe.presentAddJog()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Add jog module never told to present modally on view controller")
                        }
                }
        }
        
        func testPresentLoginWithAnythingShouldTellLoginModuleToPresentModallyOnJogsModuleNavigationController() {
                expectation = expectationWithDescription("Login module present modally on view controller from present login")
                
                wireframe._loginModule = self
                
                wireframe.presentLogin()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Login Module never told to present modally")
                        }
                }
        }
        
        // MARK: - Delegate
        
        // MARK: - Routing
        func presentingJogs() {
                if let exp = expectation {
                        if exp.description == "Presenter told presenting jogs from wireframe present in window" {
                                exp.fulfill()
                        }
                }
        }
        
        // MARK: - JogsWindow
        var rootViewController: UIViewController? {
                willSet {
                        if let exp = expectation {
                                if exp.description == "Window set root view controller to module navigation controller" {
                                        exp.fulfill()
                                        
                                        XCTAssertEqual(newValue, wireframe.moduleNavigationController, "Root view controller should be set to the module navigation controller")
                                }
                        }
                }
        }
        
        // MARK: - Add Jog Module Interface
        func presentModallyOnViewController(viewController: AddJogModalViewController) {
                if let exp = expectation {
                        if exp.description == "Add jog module present modally on view controller from present add jog" {
                                exp.fulfill()
                                
                                XCTAssert(viewController === wireframe.moduleNavigationController ? true : false, "View controller should be the jog navigation controller")
                        }
                }
        }
        
        // MARK: - Login Delegate
        func testLoginCompletedWithAnythingShouldTellThatLoginModuleToDismiss() {
                expectation = expectationWithDescription("Dismiss from login completed")
                
                wireframe.loginCompleted(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Login module never told to dismiss")
                        }
                }
        }
        
        // MARK: - Add Jog Delegate
        func testAddJogCancelledWithNonNilModuleShouldTellModuleToDismissAndSetWireframeAddJogModuleToNil() {
                expectation = expectationWithDescription("Dismiss from add jog cancelled")
                
                wireframe.addJogCancelled(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Module never told to dismiss")
                        }
                }
        }
        
        func testAddJogCompleteWithNonNilModuleShouldTellModuleToDismissAndSetWireframeAddJogModuleToNil() {
                expectation = expectationWithDescription("Dismiss from add jog cancelled")
                
                wireframe.addJogCancelled(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Module never told to dismiss")
                        }
                }
        }
        
        // MARK: - Login Module Interface
        func dismiss() {
                if let exp = expectation {
                        if exp.description == "Dismiss from login completed" {
                                exp.fulfill()
                        }
                }
                
                if let exp = expectation {
                        if exp.description == "Dismiss from add jog cancelled" {
                                exp.fulfill()
                        }
                }
        }
        
        func presentModallyOnViewController(viewController: LoginModalViewController) {
                if let exp = expectation {
                        if exp.description == "Login module present modally on view controller from present login" {
                                exp.fulfill()
                                
                                XCTAssert(viewController === wireframe.moduleNavigationController ? true : false, "View Controller should be the jogs modules navigation controller")
                        }
                }
        }
        
        // MARK: - Add Jog Module Interface
        //Dismiss is already in Login Module Interface section
        
}
