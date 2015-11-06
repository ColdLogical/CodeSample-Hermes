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

class JogsInteractorTests: XCTestCase, JogsInteractorOutput, JogsInteractorRoleQuery {
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
        func testSuccessFetchingJogsWith3JogsShouldTellPresenterFetched3Jogs() {
                expectation = expectationWithDescription("Presenter fetched jogs from success fetching jogs")
                
                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()
                
                interactor.successFetchingJogs([j1, j2, j3])
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that jogs were fetched")
                        }
                }
        }
        
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
       
        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryGetObjectsInBackground() {
                expectation = expectationWithDescription("Role query get objects in background from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
                interactor.roleQuery = self
                
                interactor.fetchCurrentUser()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to get objects in background")
                        }
                }
        }
        
        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryWhereKeyNameEqualToAdmin() {
                expectation = expectationWithDescription("Role query where key name equal to admin from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
                interactor.roleQuery = self
                
                interactor.fetchCurrentUser()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to set name to admin")
                        }
                }
        }
        
        
        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryWhereKeyUsersEqualToCurrentUser() {
                expectation = expectationWithDescription("Role query where key user equal to current user from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
                interactor.roleQuery = self
                
                interactor.fetchCurrentUser()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to set user to current user")
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
        func deletedJog() {
                
        }
        
        func failedDeletingJog() {
                
        }
        
        func failedFetchingCurrentUser() {
                if let exp = expectation {
                        if exp.description == "Presenter failed fetching current user from fetch current user" {
                                exp.fulfill()
                        }
                }
        }
        
        func failedFetchingJogs() {
        }
        
        func fetchedCurrentUser(currentUser: PFUser, isAdmin: Bool) {
                if let exp = expectation {
                        if exp.description == "Presenter fetched current user from fetch current user" {
                                exp.fulfill()
                                
                                XCTAssertEqual("Your Mom", currentUser.username, "Current user's username should be Your Mom")
                        }
                }
        }
        
        func fetchedJogs(jogs: [Jog]) {
                if let exp = expectation {
                        if exp.description == "Presenter fetched jogs from success fetching jogs" {
                                exp.fulfill()
                                
                                XCTAssertEqual(3, jogs.count, "Jogs count should be 3")
                        }
                }
        }
        
        // MARK: - Role Query Mocking
        func getFirstObjectInBackgroundWithBlock(block: ((PFObject?, NSError?) -> Void)?) {
                if let exp = expectation {
                        if exp.description == "Role query get objects in background from fetch current user" {
                                exp.fulfill()
                        }
                }
        }
        
        func whereKey(key: String, equalTo: AnyObject) -> Self {
                if let exp = expectation {
                        if exp.description == "Role query where key name equal to admin from fetch current user" &&
                                key == "name" {
                                exp.fulfill()
                                
                                let string = equalTo as! String
                                XCTAssertEqual("Admin", string, "equalTo should be Admin")
                        }
                }
                
                if let exp = expectation {
                        if exp.description == "Role query where key user equal to current user from fetch current user" &&
                                key == "users" {
                                exp.fulfill()
                                
                                let user = equalTo as! PFUser
                                XCTAssertEqual("Awesome", user.username, "Username should be Awesome")
                        }
                }
                
                return self
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
                user.username = "Awesome"
                return user
        }
        
        class func logOut() {
                //Does nothing, required by protocol
        }
}