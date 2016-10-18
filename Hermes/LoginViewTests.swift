//
//  LoginViewTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class LoginViewTests: XCTestCase, LoginViewToPresenterInterface {
        var view = LoginView()
	var window = UIWindow()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()

                let sb = UIStoryboard(name: kLoginStoryboardIdentifier, bundle: Bundle(for: LoginView.self))
                view = sb.instantiateViewController(withIdentifier: kLoginViewIdentifier) as! LoginView
		view.loadView()
                view.presenter = self

		window.rootViewController = view
		window.makeKeyAndVisible()
        }
        
        override func tearDown() {
                super.tearDown()
		view = LoginView()
		window = UIWindow()
                expectation = nil
        }
        
        // MARK: - Operational
        func testLoginTappedWithUsernameIAmPasswordAwesomeShouldTellPresenterUserTappedRegisterWithUsernameIAmPasswordAwesome() {
                expectation = expectation(description: "Presenter user tapped login from login tapped")
                
                view.usernameField!.text = "I Am"
                view.passwordField!.text = "Awesome"
                
                view.loginTapped(nil)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that login was tapped")
                        }
                }
        }
        
        func testLoginTappedWithNilPasswordNonNilUsernameShouldSetMessageTextToPleaseEnterAPassword() {
                view.usernameField!.text = "I Am Awesome"
                view.passwordField!.text = nil
                
                view.loginTapped(nil)
                
                XCTAssertEqual("Please enter a password", view.messageLabel!.text, "Message label text should be Please enter a password")
        }
        
        func testLoginTappedWithNilUsernameShouldSetMessageTextToPleaseEnterAUsername() {
                view.usernameField!.text = nil
                
                view.loginTapped(nil)
                
                XCTAssertEqual("Please enter a username", view.messageLabel!.text, "Message label text should be Please enter a username")
        }
        
        func testRegisterTappedWithAnythingShouldTellPresenterUserTappedRegister() {
                expectation = expectation(description: "Presenter user tapped register from register tapped")
                
                view.registerTapped(nil)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that register was tapped")
                        }
                }
        }

        // MARK: - View Interface
        func testShowMessageWithTextIAmAwesomeShouldSetMessageLabelNotHiddenAndTextToIAmAwesome() {
                view.showMessage("I Am Awesome")
                
                XCTAssertFalse(view.messageLabel!.isHidden, "Message label should not be hidden")
                XCTAssertEqual("I Am Awesome", view.messageLabel!.text, "Message label's text should be I Am Awesome")
        }

        // MARK: - Presenter Interface
        func userTappedLogin(_ username: String, password: String) {
                if let exp = expectation {
                        if exp.description == "Presenter user tapped login from login tapped" {
                                exp.fulfill()
                                
                                XCTAssertEqual("I Am", username, "Username should be I Am")
                                XCTAssertEqual("Awesome", password, "Password should be Awesome")
                        }
                }
        }
        
        func userTappedRegister() {
                if let exp = expectation {
                        if exp.description == "Presenter user tapped register from register tapped" {
                                exp.fulfill()
                        }
                }
        }
}
