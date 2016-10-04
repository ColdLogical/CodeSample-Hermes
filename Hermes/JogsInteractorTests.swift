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
        
        @objc func receivedNotification(_ notification: Notification) {
                if let exp = expectation {
                        if exp.description == "User service log out from logout" {
                                exp.fulfill()
                        }
                }
        }
        
        // MARK: - Operational
        func testSuccessFetchingJogsWith3JogsShouldTellPresenterFetched3Jogs() {
                expectation = expectation(description: "Presenter fetched jogs from success fetching jogs")
                
                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()
                
                interactor.successFetchingJogs([j1, j2, j3])
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that jogs were fetched")
                        }
                }
        }
        
        // MARK: - Interactor Input
        func testFetchCurrentUserWithNilCurrentUserShouldCallPresenterFailedFetchingCurrentUser() {
                expectation = expectation(description: "Presenter failed fetching current user from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsNil.self
                
                interactor.fetchCurrentUser()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("User Service current user never called")
                        }
                }
        }
       
        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryGetObjectsInBackground() {
                expectation = expectation(description: "Role query get objects in background from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
//                interactor.roleQuery = self
                
                interactor.fetchCurrentUser()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to get objects in background")
                        }
                }
        }
        
        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryWhereKeyNameEqualToAdmin() {
                expectation = expectation(description: "Role query where key name equal to admin from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
//                interactor.roleQuery = self
                
                interactor.fetchCurrentUser()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to set name to admin")
                        }
                }
        }
        
        
        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryWhereKeyUsersEqualToCurrentUser() {
                expectation = expectation(description: "Role query where key user equal to current user from fetch current user")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
//                interactor.roleQuery = self
                
                interactor.fetchCurrentUser()
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to set user to current user")
                        }
                }
        }
        
        func testLogoutWithAnythingShouldTellUserServiceToLogOut() {
                expectation = expectation(description: "User service log out from logout")
                
                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsNil.self
                NotificationCenter.default.addObserver(self, selector: #selector(JogsInteractorTests.receivedNotification(_:)), name: NSNotification.Name(rawValue: "User service log out from logout"), object: nil)
                
                interactor.logout()
                
                NotificationCenter.default.removeObserver(self)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
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
        
        func fetchedCurrentUser(_ currentUser: PFUser, isAdmin: Bool) {
                if let exp = expectation {
                        if exp.description == "Presenter fetched current user from fetch current user" {
                                exp.fulfill()
                                
                                XCTAssertEqual("Your Mom", currentUser.username, "Current user's username should be Your Mom")
                        }
                }
        }
        
        func fetchedJogs(_ jogs: [Jog]) {
                if let exp = expectation {
                        if exp.description == "Presenter fetched jogs from success fetching jogs" {
                                exp.fulfill()
                                
                                XCTAssertEqual(3, jogs.count, "Jogs count should be 3")
                        }
                }
        }
        
        // MARK: - Role Query Mocking
        func getFirstObjectInBackgroundWithBlock(_ block: ((PFObject?, NSError?) -> Void)?) {
                if let exp = expectation {
                        if exp.description == "Role query get objects in background from fetch current user" {
                                exp.fulfill()
                        }
                }
        }
        
        func whereKey(_ key: String, equalTo: AnyObject) -> Self {
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
                NotificationCenter.default.post(name: Notification.Name(rawValue: "User service log out from logout"), object: nil)
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
