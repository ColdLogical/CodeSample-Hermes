//
//  JogsPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse
import XCTest

@testable import Hermes

class JogsPresenterTests: XCTestCase, JogsInteractorInput, JogsViewInterface, JogsWireframeInterface {
        var presenter = JogsPresenter()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                presenter = JogsPresenter()
                presenter.interactor = self
                presenter.view = self
                presenter.wireframe = self
        }
        
        override func tearDown() {
                super.tearDown()
		presenter = JogsPresenter()
                expectation = nil;
        }
        
        // MARK: - Operational
        func testPresentingJogsWithAnythinyShouldTellInteractorToFetchCurrentUser() {
                expectation = expectationWithDescription("Interactor fetch current user from presenter presenting jogs")
                
                presenter.presentingJogs()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to fetch current user")
                        }
                }
        }

        // MARK: - Interactor Output
        func testFailedFetchingCurrentUserWithAnythingShouldTellWireframeToPresentLogin() {
                expectation = expectationWithDescription("Wireframe presenter login from failed fetching current user")
                
                presenter.failedFetchingCurrentUser()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present login")
                        }
                }
        }
        
        func testFetchedCurrentUserWithUsernameSarahKerriganShouldTellInteractorToFetchJogsForSarahKerrigan() {
                expectation = expectationWithDescription("Fetch jogs for user from fetched current user")
                
                let user = PFUser()
                user.username = "Sarah Kerrigan"
                
                presenter.fetchedCurrentUser(user)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to fetch jogs for user")
                        }
                }
        }
        
        func testFetchedJogsWith3JogsShouldTellViewToShow3Jogs() {
                expectation = expectationWithDescription("View show jogs from fetched jogs")
                
                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()
                
                presenter.fetchedJogs([j1, j2, j3])
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show jogs")
                        }
                }
        }

        // MARK: - Presenter Interface
        func testUserTappedAddWithAnythingShouldTellWireframetPresentAddJog() {
                expectation = expectationWithDescription("Wireframe present add jog from user tapped add")
                
                presenter.userTappedAdd()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present add jog")
                        }
                }
        }
        
        func testUserTappedLogoutWithAnythingShouldTellInteractorToLogout() {
                expectation = expectationWithDescription("Interactor logout from user tapped logout")
                
                presenter.userTappedLogout()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to logout")
                        }
                }
        }
        
        func testUserTappedLogoutWithAnythingShouldTellWireframeToPresentLogin() {
                expectation = expectationWithDescription("Wireframe present login from user tapped logout")
                
                presenter.userTappedLogout()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present login")
                        }
                }
        }

        // MARK: - Routing

        // MARK: - Interactor Input
        func fetchCurrentUser() {
                if let exp = expectation {
                        if exp.description == "Interactor fetch current user from presenter presenting jogs" {
                                exp.fulfill()
                        }
                }
        }
        
        func fetchJogs(user: PFUser?) {
                if let exp = expectation {
                        if exp.description == "Fetch jogs for user from fetched current user" {
                                exp.fulfill()
                                
                                XCTAssertEqual("Sarah Kerrigan", user!.username, "Username should be Sarah Kerrigan")
                        }
                }
        }
        
        func logout() {
                if let exp = expectation {
                        if exp.description == "Interactor logout from user tapped logout" {
                                exp.fulfill()
                        }
                }
        }
        
        // MARK: - View Interface
        func showJogs(jogs: [Jog]) {
                if let exp = expectation {
                        if exp.description == "View show jogs from fetched jogs" {
                                exp.fulfill()
                                
                                XCTAssertEqual(3, jogs.count, "Jogs count should be 3")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func presentAddJog() {
                if let exp = expectation {
                        if exp.description == "Wireframe present add jog from user tapped add" {
                                exp.fulfill()
                        }
                }
        }
        
        func presentLogin() {
                if let exp = expectation {
                        if exp.description == "Wireframe presenter login from failed fetching current user" ||
                                exp.description == "Wireframe present login from user tapped logout" {
                                exp.fulfill()
                        }
                }
        }
        
}
