//
//  RegisterPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Supremacy

class RegisterPresenterTests: XCTestCase, RegisterInteractorInput, RegisterViewInterface, RegisterWireframeInterface {
        var presenter = RegisterPresenter()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                presenter = RegisterPresenter()
                presenter.interactor = self
                presenter.view = self
                presenter.wireframe = self
        }
        
        override func tearDown() {
                super.tearDown()
		presenter = RegisterPresenter()
                expectation = nil;
        }
        
        // MARK: - Operational

        // MARK: - Interactor Output
        func testSignUpFailureWithAnythingShouldTellViewToDisplayFailedToSignUpTryAgain() {
                expectation = expectationWithDescription("View show failure message from sign up failure")
                
                let error = NSError(domain: "Muldor", code: 666, userInfo: nil)
                
                presenter.signUpFailure(error)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show sign up failure message")
                        }
                }
        }
        
        func testSignUpSuccessWithAnythingShouldTellWireframeRegistrationFinished() {
                expectation = expectationWithDescription("Wireframe register finished from sign up success")
                
                presenter.signUpSuccess()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told that registration has finished")
                        }
                }
        }

        // MARK: - Presenter Interface
        func testUserTappedRegisterWithAnythingShouldTellViewToShowRegisteringMessage() {
                expectation = expectationWithDescription("View show register message from user tapped register")
                
                presenter.userTappedRegister("Anything", password: "Anything")
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to present register module")
                        }
                }
        }
        
        func testUserTappedRegisterWithUsernameIAmAndPasswordAwesomeShouldTellInteractorToRegisterUser() {
                expectation = expectationWithDescription("Interactor register user from user tapped register")
                
                presenter.userTappedRegister("I Am", password: "Awesome")
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to present register module")
                        }
                }
        }
        
        // MARK: - Routing
        func testPresentingWithAnythingShouldTellViewToShowAnEmptyMessage() {
                expectation = expectationWithDescription("View show empty message from presenting")
                
                presenter.presenting()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show empty message")
                        }
                }
        }

        // MARK: - Interactor Input
        func registerUser(username: String, password: String) {
                if let exp = expectation {
                        if exp.description == "Interactor register user from user tapped register" {
                                exp.fulfill()
                                
                                XCTAssertEqual("I Am", username, "Username should be I Am")
                                XCTAssertEqual("Awesome", password, "Password should be Awesome")
                        }
                }
        }
        
        // MARK: - View Interface
        func showMessage(message: String) {
                if let exp = expectation {
                        if exp.description == "View show register message from user tapped register" {
                                exp.fulfill()
                                
                                XCTAssertEqual("Registering...", message, "Message should be Registering...")
                        }
                }
                
                if let exp = expectation {
                        if exp.description == "View show failure message from sign up failure" {
                                exp.fulfill()
                                
                                XCTAssertEqual("Failed to register... Try again please", message, "Message should be Failed to register... Try again please")
                        }
                }
                
                if let exp = expectation {
                        if exp.description == "View show empty message from presenting" {
                                exp.fulfill()
                                
                                XCTAssertEqual("", message, "Message should be empty")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func registrationFinished() {
                if let exp = expectation {
                        if exp.description == "Wireframe register finished from sign up success" {
                                exp.fulfill()
                        }
                }
        }
        
}
