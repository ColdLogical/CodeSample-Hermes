//
//  JogsPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
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
        
        func logout() {
                if let exp = expectation {
                        if exp.description == "Interactor logout from user tapped logout" {
                                exp.fulfill()
                        }
                }
        }
        
        // MARK: - View Interface
        
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
