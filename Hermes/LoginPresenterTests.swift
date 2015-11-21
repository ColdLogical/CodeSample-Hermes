//
//  LoginPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Supremacy

class LoginPresenterTests: XCTestCase, LoginInteractorInput, LoginViewInterface, LoginWireframeInterface {
        var presenter = LoginPresenter()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                presenter = LoginPresenter()
                presenter.interactor = self
                presenter.view = self
                presenter.wireframe = self
        }
        
        override func tearDown() {
                super.tearDown()
		presenter = LoginPresenter()
                expectation = nil;
        }
        
        // MARK: - Operational

        // MARK: - Interactor Output
        func testFailedLoginWithAnythingShouldTellViewShowMessageLoginFailedTryAgain() {
                expectation = expectationWithDescription("View show message login failed from failed login")
                
                presenter.failedLogin(nil)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show login failed message")
                        }
                }
        }
        
        func testLoginSuccessWithAnythingShouldTellWireframeLoginFinished() {
                expectation = expectationWithDescription("Wireframe login finished from login Success")
                
                presenter.loginSuccess()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told login finished")
                        }
                }
        }

        // MARK: - Presenter Interface
        func testUserTappedLoginWithUsernameIAmAndPasswordAwesomeShouldTellInteractorToLoginWithUsernameIAmAndPasswordAwesome() {
                expectation = expectationWithDescription("Interactor login from user tapped login")
                
                presenter.userTappedLogin("I Am", password: "Awesome")
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to login")
                        }
                }
        }
        
        func testUserTappedLoginWithAnythingShouldTellViewToShowLoggingIn() {
                expectation = expectationWithDescription("View show logging in message from user tapped login")
                
                presenter.userTappedLogin("Anything", password: "Anything")
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show logging in message")
                        }
                }
        }
        
        func testUserTappedRegisterWithAnythingShouldTellWireframeToPresentRegisterModule() {
                expectation = expectationWithDescription("Wireframe present register from user tapped register")
                
                presenter.userTappedRegister()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present register module")
                        }
                }
        }

        // MARK: - Routing

        // MARK: - Interactor Input
        func login(username: String, password: String) {
                if let exp = expectation {
                        if exp.description == "Interactor login from user tapped login" {
                                exp.fulfill()
                                
                                XCTAssertEqual("I Am", username, "Username should be I Am")
                                XCTAssertEqual("Awesome", password, "Password should be I Am")
                        }
                }
        }
        
        // MARK: - View Interface
        func showMessage(message: String) {
                if let exp = expectation {
                        if exp.description == "View show logging in message from user tapped login" {
                                exp.fulfill()
                                
                                XCTAssertEqual(message, "Logging In...", "Message should be Logging In...")
                        }
                }
                
                if let exp = expectation {
                        if exp.description == "View show message login failed from failed login" {
                                exp.fulfill()
                                
                                XCTAssertEqual(message, "Login failed. Please try again.", "Message should be Login Failed. Please try again.")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func loginFinished() {
                if let exp = expectation {
                        if exp.description == "Wireframe login finished from login Success" {
                                exp.fulfill()
                        }
                }
        }
        
        func presentRegister() {
                if let exp = expectation {
                        if exp.description == "Wireframe present register from user tapped register" {
                                exp.fulfill()
                        }
                }
        }
        
}
