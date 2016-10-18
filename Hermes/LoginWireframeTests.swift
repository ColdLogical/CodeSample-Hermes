//
//  LoginWireframeTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class LoginWireframeTests: XCTestCase, LoginDelegate, LoginNavigation, LoginWireframeToPresenterInterface, LoginModalViewController, RegisterModuleInterface {
        var wireframe = LoginWireframe()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                wireframe.delegate = self;
                wireframe.presenter = self;
        }
        
        override func tearDown() {
                super.tearDown()
		wireframe = LoginWireframe()
                expectation = nil;
        }
        
        // MARK: - Init
        func testInitWithNothingShouldInstantiateVIPERStackAndConnectLayers() {
                wireframe = LoginWireframe()
                
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
        func testLoginInteractorLazyLoaderWithNilValueShouldInstantiateInteractor() {
                XCTAssertNotNil (wireframe.moduleInteractor, "Lazy loader should create a new interactor if it doesnt exist")
                XCTAssertTrue (wireframe.moduleInteractor.isKind(of: LoginInteractor.self), "Lazily loader should create an instance of LoginInteractor")
        }

        func testLoginPresenterLazyLoaderWithNilValueShouldInstantiatePresenter() {
                XCTAssertNotNil (wireframe.modulePresenter, "Lazy loader should create a new presenter if it doesnt exist")
                XCTAssertTrue (wireframe.modulePresenter.isKind(of: LoginPresenter.self), "Lazily loader should create an instance of LoginPresenter")
        }

        func testLoginViewLazyLoaderWithNilValueShouldInstantiateView() {
                XCTAssertNotNil (wireframe.moduleView, "Lazy loader should create a new view if it doesnt exist")
                XCTAssertTrue (wireframe.moduleView.isKind(of: LoginView.self), "Lazily loader should create an instance of LoginView")
        }

        func testStoryboardWithNothingShouldReturnStoryboardWithkLoginStoryboardIdentifier() {
                let storyboard = LoginWireframe.storyboard()
                
                XCTAssertEqual (kLoginStoryboardIdentifier, storyboard.value(forKey: "name") as! String?, "Storyboard identifier should be the constant identifier defined in the LoginWireframeProtocols file")
        }

        // MARK: - Module Interface
        func testDismissWithAnythingShouldTellViewToDismissViewControllerAnimatedTrueAndNilCompletion() {
                expectation = expectation(description: "Dismiss view controller animated from dismiss ")
                
                wireframe.view = self;
                
                wireframe.dismiss()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("View never told to dismiss view controller")
                        }
                }
        }
        
        func testPresentModallyOnViewControllerWithNonNilViewControllerShouldCallPresentViewControllerOnTheViewControllerPassedIn() {
                expectation = expectation(description: "View controller present view controller from present modally on view controller")
                
                wireframe.presentModallyOnViewController(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("View controller never told to present view controller")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func testLoginFinishedWithNonNilDelegateShouldTellDelegateLoginCompleted() {
                expectation = expectation(description: "Delegate login completed from login finished")
                
                wireframe.loginFinished()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Delegate never told that login completed")
                        }
                }
        }
        
        func testPresentRegisterWithAnythingShouldTellRegisterModuleToPushOntoModulesNavigationController() {
                expectation = expectation(description: "Register module push on navigation controller from present register")
                
                wireframe.registerModule = self
                
                wireframe.presentRegister()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Register module never told to push onto login's navigation controller")
                        }
                }
        }
        
        // MARK: - Register Delegate
        func testRegistrationCompletedWithAnythingShouldTellThatRegisterModuleToPopView() {
                expectation = expectation(description: "Register module pop view from registration completed")
                
                wireframe.registrationCompleted(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Register module never told to pop view")
                        }
                }
        }
        
        func testRegistrationCompletedWithNonNilDelegateShouldTellDelegateLoginCompleted() {
                expectation = expectation(description: "Delegate login completed from registration completed")
                
                wireframe.registrationCompleted(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Delegate never told that login was completed")
                        }
                }
        }
        
        // MARK: - Delegate
        func loginCompleted(_ loginModule: LoginModuleInterface) {
                if let exp = expectation {
                        if exp.description == "Delegate login completed from registration completed" ||
                                exp.description == "Delegate login completed from login finished" {
                                exp.fulfill()
                                
                                XCTAssert(loginModule === wireframe ? true : false, "Login module should be the login modules wireframe")
                        }
                }
        }
        
        // MARK: - Login Navigation
        func dismissViewControllerAnimated(_ flag: Bool, completion: (() -> Void)?) {
                if let exp = expectation {
                        if exp.description == "Dismiss view controller animated from dismiss " {
                                exp.fulfill()
                                
                                XCTAssertTrue(flag, "Animated should be true")
                                XCTAssertNil(completion, "Completion block should be nil")
                        }
                }
        }
        
        // MARK: - WireframeToPresenterInterface
        
        // MARK: - LoginModalViewController
        func presentViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
                if let exp = expectation {
                        if exp.description == "View controller present view controller from present modally on view controller" {
                                exp.fulfill()
                                
                                XCTAssert(viewControllerToPresent === wireframe.moduleNavigationController ? true : false, "viewControllerToPresent should be the login modules navigation controller")
                                XCTAssertTrue(flag, "Animated flag should be true")
                                XCTAssertNil(completion, "Completion should be nil")
                        }
                }
        }
        
        // MARK: - Register Module Interface
        func popViewFromNavigationController(_ navigationController: RegisterNavigationController) {
                if let exp = expectation {
                        if exp.description == "Register module pop view from registration completed" {
                                exp.fulfill()
                                
                                XCTAssert(navigationController === wireframe.moduleNavigationController ? true : false, "Navigation controller should be the login module's navigation controller")
                        }
                }
        }
        
        func pushOnNavigationController(_ viewController: RegisterNavigationController) {
                if let exp = expectation {
                        if exp.description == "Register module push on navigation controller from present register" {
                                exp.fulfill()
                                
                                XCTAssert(viewController === wireframe.moduleNavigationController ? true : false, "viewController should be the login modules navigation controller")
                        }
                }
        }
}
