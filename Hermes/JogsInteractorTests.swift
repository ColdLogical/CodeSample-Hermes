//
//  JogsInteractorTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse
import XCTest

@testable import Hermes

class JogsInteractorTests: XCTestCase, JogsInteractorOutput {
        var interactor = JogsInteractor()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                interactor = JogsInteractor()
                interactor.presenter = self
        }
        
        override func tearDown() {
                super.tearDown()
		interactor = JogsInteractor()
                expectation = nil;
        }
        
        @objc func receivedNotification(notification: NSNotification) {
                if let exp = expectation {
                        if exp.description == "User service log out from logout" {
                                exp.fulfill()
                        }
                }
        }
        
        // MARK: - Operational
        
        // MARK: - Interactor Input
        func testFetchCurrentUserWithNilCurrentUserShouldCallPresenterFailedFetchingCurrentUser() {
                expectation = expectationWithDescription("Presenter failed fetching current user from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsNil.self
                
                interactor.fetchCurrentUser()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("User Service current user never called")
                        }
                }
        }

        func testFetchCurrentUserWithNonNilCurrentUserShouldCallPresenterFetchedCurrentUser() {
                expectation = expectationWithDescription("Presenter fetched current user from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
                
                interactor.fetchCurrentUser()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("User Service current user never called")
                        }
                }
        }
        
        func testLogoutWithAnythingShouldTellUserServiceToLogOut() {
                expectation = expectationWithDescription("User service log out from logout")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsNil.self
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedNotification:", name: "User service log out from logout", object: nil)
                
                interactor.logout()
                
                NSNotificationCenter.defaultCenter().removeObserver(self)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("User service never told to log out")
                        }
                }
        }

        // MARK: - Interactor Output
        func failedFetchingCurrentUser() {
                if let exp = expectation {
                        if exp.description == "Presenter failed fetching current user from fetch current user" {
                                exp.fulfill()
                        }
                }
        }
        
        func fetchedCurrentUser(currentUser: PFUser) {
                if let exp = expectation {
                        if exp.description == "Presenter fetched current user from fetch current user" {
                                exp.fulfill()
                                
                                XCTAssertEqual("Your Mom", currentUser.username, "Current user's username should be Your Mom")
                        }
                }
        }
}

class JogsInteractorUserServiceCurrentUserReturnsNil : JogsInteractorUserService {
        class func currentUser() -> PFUser? {
                return nil;
        }
        
        class func logOut() {
                NSNotificationCenter.defaultCenter().postNotificationName("User service log out from logout", object: nil)
        }
}

class JogsInteractorUserServiceCurrentUserReturnsUser : JogsInteractorUserService {
        required init() {
        }
        
        class func currentUser() -> PFUser? {
                let user = PFUser()
                user.username = "Your Mom"
                return user
        }
        
        class func logOut() {
                //Does nothing, required by protocol
        }
}