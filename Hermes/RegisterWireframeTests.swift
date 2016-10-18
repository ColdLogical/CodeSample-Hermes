//
//  RegisterWireframeTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class RegisterWireframeTests: XCTestCase, RegisterDelegate, RegisterWireframeToPresenterInterface, RegisterNavigationController {
        var wireframe = RegisterWireframe()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                wireframe.delegate = self;
                wireframe.presenter = self;
        }
        
        override func tearDown() {
                super.tearDown()
		wireframe = RegisterWireframe()
                expectation = nil;
        }
        
        // MARK: - Init
        func testInitWithNothingShouldInstantiateVIPERStackAndConnectLayers() {
                wireframe = RegisterWireframe()
                
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
        func testRegisterInteractorLazyLoaderWithNilValueShouldInstantiateInteractor() {
                XCTAssertNotNil (wireframe.moduleInteractor, "Lazy loader should create a new interactor if it doesnt exist")
                XCTAssertTrue (wireframe.moduleInteractor.isKind(of: RegisterInteractor.self), "Lazily loader should create an instance of RegisterInteractor")
        }

        func testRegisterPresenterLazyLoaderWithNilValueShouldInstantiatePresenter() {
                XCTAssertNotNil (wireframe.modulePresenter, "Lazy loader should create a new presenter if it doesnt exist")
                XCTAssertTrue (wireframe.modulePresenter.isKind(of: RegisterPresenter.self), "Lazily loader should create an instance of RegisterPresenter")
        }

        func testRegisterViewLazyLoaderWithNilValueShouldInstantiateView() {
                XCTAssertNotNil (wireframe.moduleView, "Lazy loader should create a new view if it doesnt exist")
                XCTAssertTrue (wireframe.moduleView.isKind(of: RegisterView.self), "Lazily loader should create an instance of RegisterView")
        }

        func testStoryboardWithNothingShouldReturnStoryboardWithkRegisterStoryboardIdentifier() {
                let storyboard = RegisterWireframe.storyboard()
                
                XCTAssertEqual (kRegisterStoryboardIdentifier, storyboard.value(forKey:"name") as! String?, "Storyboard identifier should be the constant identifier defined in the RegisterWireframeProtocols file")
        }

        // MARK: - Operational
        
        // MARK: - Module Interface
        func testPopViewFromNavigationControllerAnythingShouldCallNavigationPopViewControllerWithAnimatedTrue() {
                expectation = expectation(description: "Pop view controller animated from pop view from navigation controller")
                
                wireframe.popViewFromNavigationController(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Navigation controller never told to animate the pop of the register modules view controller")
                        }
                }
        }
        
        func testPushOnNavigationControllerWithAnythingShouldTellPresenterPresenting() {
                expectation = expectation(description: "Presenter presenting from push on navigation controller")
                
                wireframe.pushOnNavigationController(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that the module is initially presenting")
                        }
                }
        }
        
        func testPushOnNavigationControllerWithNonNilNavigationControllerShouldCallNavigationPushViewControllerWithModuleViewControllerAnimatedTrue() {
                expectation = expectation(description: "Push view controller animated from push on navigation controller")
                
                wireframe.pushOnNavigationController(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Navigation controller never told to animate the push of the register modules view controller")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func testRegistrationFinishedWithNonNilDelegateShouldTellDelegateRegistrationCompleted() {
                expectation = self.expectation(description: "Delegate registration completed from wireframe registration finished")
                
                wireframe.registrationFinished()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Delegate never told that registration completed")
                        }
                }
        }
        
        // MARK: - Delegate
        func registrationCompleted(_ registrationModule: RegisterModuleInterface) {
                if let exp = expectation {
                        if exp.description == "Delegate registration completed from wireframe registration finished" {
                                exp.fulfill()
                                
                                XCTAssert(registrationModule === wireframe ? true : false, "Registration module should be the wireframe")
                        }
                }
        }
        
        // MARK: - WireframeToPresenterInterface
        func presenting() {
                if let exp = expectation {
                        if exp.description == "Presenter presenting from push on navigation controller" {
                                exp.fulfill()
                        }
                }
        }
        
        // MARK: - Register Navigation Controller
        func popViewControllerAnimated(_ animated: Bool) -> UIViewController? {
                if let exp = expectation {
                        if exp.description == "Pop view controller animated from pop view from navigation controller" {
                                exp.fulfill()
                                
                                XCTAssertTrue(animated, "Animated should be true")
                        }
                }
                
                return nil
        }
        
        func pushViewController(_ viewController: UIViewController, animated: Bool) {
                if let exp = expectation {
                        if exp.description == "Push view controller animated from push on navigation controller" {
                                exp.fulfill()
                                
                                XCTAssert(viewController === wireframe.moduleView, "viewController should be the modules view")
                                XCTAssertTrue(animated, "Animated should be true")
                        }
                }
        }
}
