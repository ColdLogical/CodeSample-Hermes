//
//  LoginInteractorTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse
import XCTest

@testable import Supremacy

class LoginInteractorTests: XCTestCase, LoginInteractorOutput, LoginInteractorUser {
        var interactor = LoginInteractor()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                interactor = LoginInteractor()
                interactor.presenter = self
        }
        
        override func tearDown() {
                super.tearDown()
		interactor = LoginInteractor()
                expectation = nil;
        }
        
        @objc func receivedNotification(notification: NSNotification) {
                if let exp = expectation {
                        if exp.description == "Log in with username in background from login" {
                                exp.fulfill()
                                
                                XCTAssertEqual("I Am", notification.object!["username"], "Username should be I Am")
                                XCTAssertEqual("Awesome", notification.object!["password"], "Password should be Awesome")
                        }
                }
        }
        
        // MARK: - Operational
        func testLoginFailedWithAnythingShouldTellPresenterLoginFailure() {
                expectation = expectationWithDescription("Presenter failed login from login failed")
                
                let error = NSError(domain: "Muldor", code: 666, userInfo: nil)
                
                interactor.loginFailed(error)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that login failed")
                        }
                }
        }
        
        func testLoginSucceededWithAnythingShouldTellPresenterLoginSuccess() {
                expectation = expectationWithDescription("Presenter login success in from login succeeded")
                
                interactor.loginSucceeded()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told login succeeded")
                        }
                }
        }

        // MARK: - Interactor Input
        func testLoginWithUsernameIAmAndPasswordAwesomeShouldCallLoginServiceLogInWithUsernameInBackground() {
                expectation = expectationWithDescription("Log in with username in background from login")
                
                interactor.loginService = LoginInteractorTests.self
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedNotification:", name: "Log in with username in background from login", object: nil)
                
                interactor.login("I Am", password: "Awesome")
                
                NSNotificationCenter.defaultCenter().removeObserver(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Login service never told to log in with username in background")
                        }
                }
        }

        // MARK: - Interactor Output
        func failedLogin(error: NSError?) {
                if let exp = expectation {
                        if exp.description == "Presenter failed login from login failed" {
                                exp.fulfill()
                                
                                XCTAssertEqual(666, error!.code, "Error code should be 666")
                        }
                }
        }
        
        func loginSuccess() {
                if let exp = expectation {
                        if exp.description == "Presenter login success in from login succeeded" {
                                exp.fulfill()
                        }
                }
        }
        
        // MARK: - Login Interactor User
        class func logInWithUsernameInBackground(username: String, password: String, block: PFUserResultBlock?) {
                let dictionary = ["username" : username, "password" : password]
                NSNotificationCenter.defaultCenter().postNotificationName("Log in with username in background from login", object: dictionary)
        }
}