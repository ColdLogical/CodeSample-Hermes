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

@testable import Hermes

class LoginInteractorTests: XCTestCase, LoginInteractorToPresenterInterface, LoginInteractorUser {
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
        
        @objc func receivedNotification(_ notification: Notification) {
                if let exp = expectation {
                        if exp.description == "Log in with username in background from login" {
                                exp.fulfill()
                                
                                let object = notification.object as! [ String : String ]
                                
                                XCTAssertEqual("I Am", object["username"], "Username should be I Am")
                                XCTAssertEqual("Awesome", object["password"], "Password should be Awesome")
                        }
                }
        }
        
        // MARK: - Operational
        func testLoginFailedWithAnythingShouldTellPresenterLoginFailure() {
                expectation = expectation(description: "Presenter failed login from login failed")
                
                let error = NSError(domain: "Muldor", code: 666, userInfo: nil)
                
                interactor.loginFailed(error)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that login failed")
                        }
                }
        }
        
        func testLoginSucceededWithAnythingShouldTellPresenterLoginSuccess() {
                expectation = expectation(description: "Presenter login success in from login succeeded")
                
                interactor.loginSucceeded()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told login succeeded")
                        }
                }
        }

        // MARK: - Interactor Input
        func testLoginWithUsernameIAmAndPasswordAwesomeShouldCallLoginServiceLogInWithUsernameInBackground() {
                expectation = expectation(description: "Log in with username in background from login")
                
                interactor.loginService = LoginInteractorTests.self
                NotificationCenter.default.addObserver(self, selector: #selector(LoginInteractorTests.receivedNotification(_:)), name: NSNotification.Name(rawValue: "Log in with username in background from login"), object: nil)
                
                interactor.login("I Am", password: "Awesome")
                
                NotificationCenter.default.removeObserver(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Login service never told to log in with username in background")
                        }
                }
        }

        // MARK: - Interactor Output
        func failedLogin(_ error: NSError?) {
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
        class func logInWithUsernameInBackground(_ username: String, password: String, block: PFUserResultBlock?) {
                let dictionary = ["username" : username, "password" : password]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "Log in with username in background from login"), object: dictionary)
        }
}
