//
//  LoginPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Hermes

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
                expectation = expectation(description: "View show message login failed from failed login")
                
                presenter.failedLogin(nil)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show login failed message")
                        }
                }
        }
        
        func testLoginSuccessWithAnythingShouldTellWireframeLoginFinished() {
                expectation = expectation(description: "Wireframe login finished from login Success")
                
                presenter.loginSuccess()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told login finished")
                        }
                }
        }

        // MARK: - Presenter Interface
        func testUserTappedLoginWithUsernameIAmAndPasswordAwesomeShouldTellInteractorToLoginWithUsernameIAmAndPasswordAwesome() {
                expectation = expectation(description: "Interactor login from user tapped login")
                
                presenter.userTappedLogin("I Am", password: "Awesome")
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to login")
                        }
                }
        }
        
        func testUserTappedLoginWithAnythingShouldTellViewToShowLoggingIn() {
                expectation = expectation(description: "View show logging in message from user tapped login")
                
                presenter.userTappedLogin("Anything", password: "Anything")
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show logging in message")
                        }
                }
        }
        
        func testUserTappedRegisterWithAnythingShouldTellWireframeToPresentRegisterModule() {
                expectation = expectation(description: "Wireframe present register from user tapped register")
                
                presenter.userTappedRegister()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present register module")
                        }
                }
        }

        // MARK: - Routing

        // MARK: - Interactor Input
        func login(_ username: String, password: String) {
                if let exp = expectation {
                        if exp.description == "Interactor login from user tapped login" {
                                exp.fulfill()
                                
                                XCTAssertEqual("I Am", username, "Username should be I Am")
                                XCTAssertEqual("Awesome", password, "Password should be I Am")
                        }
                }
        }
        
        // MARK: - View Interface
        func showMessage(_ message: String) {
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
