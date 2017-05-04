//
//  RegisterInteractorTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse
import XCTest

@testable import Hermes

class RegisterInteractorTests: XCTestCase, RegisterInteractorToPresenterInterface, RegisterInteractorUser {
        var interactor = RegisterInteractor()

        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        var password: String? {
                willSet {
                        if let exp = expectation {
                                if exp.description == "New user set password from register user" {
                                        exp.fulfill()

                                        XCTAssertEqual(newValue, "Awesome", "New value should be Awesome")
                                }
                        }
                }
        }
        var username: String? {
                willSet {
                        if let exp = expectation {
                                if exp.description == "New user set username from register user" {
                                        exp.fulfill()

                                        XCTAssertEqual(newValue, "I Am", "New value should be I Am")
                                }
                        }
                }
        }

        override func setUp() {
                super.setUp()
                interactor = RegisterInteractor()
                interactor.presenter = self
        }

        override func tearDown() {
                super.tearDown()
		interactor = RegisterInteractor()
                expectation = nil
        }

        // MARK: - Operational
        func testSignUpFailedWithAnythingShouldTellPresenterSignUpFailed() {
                expectation = expectation(description: "Presenter sign up failure from interactor sign up failed")

                let error = NSError(domain: "Muldor", code: 666, userInfo: nil)

                interactor.signUpFailed(error)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that sign up failed")
                        }
                }
        }
        func testSignUpSucceededWithAnythingShouldTellPresenterSignUpSuccess() {
                expectation = expectation(description: "Presenter sign up success from interactor sign up succeeded")

                interactor.signUpSucceeded()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that sign up success")
                        }
                }
        }

        // MARK: - Interactor Input
        func testRegisterUserWithPasswordAwesomeShouldSetNewUserPasswordToAwesome() {
                expectation = expectation(description: "New user set password from register user")

                interactor.newUser = self

                interactor.registerUser("Anything", password: "Awesome")

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("New user never told to set password")
                        }
                }
        }

        func testRegisterUserWithUsernameIAmShouldSetNewUsersUsernameToIAm() {
                expectation = expectation(description: "New user set username from register user")

                interactor.newUser = self

                interactor.registerUser("I Am", password: "Anything")

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("New user never told to set username")
                        }
                }
        }

        func testRegisterUserWithAnythingShouldTellNewUserToSignUpInBackground() {
                expectation = expectation(description: "New user sign up in background from register user")

                interactor.newUser = self

                interactor.registerUser("Anything", password: "Anything")

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("New user never told to set username")
                        }
                }
        }

        // MARK: - Interactor Output
        func signUpFailure(_ error: NSError?) {
                if let exp = expectation {
                        if exp.description == "Presenter sign up failure from interactor sign up failed" {
                                exp.fulfill()

                                XCTAssertEqual(error!.code, 666, "Error code should be 666")
                        }
                }
        }

        func signUpSuccess() {
                if let exp = expectation {
                        if exp.description == "Presenter sign up success from interactor sign up succeeded" {
                                exp.fulfill()
                        }
                }
        }

        // MARK: - RegisterInteractorUser
        func signUpInBackgroundWithBlock(_ block: PFBooleanResultBlock?) {
                if let exp = expectation {
                        if exp.description == "New user sign up in background from register user" {
                                exp.fulfill()
                        }
                }
        }
}
