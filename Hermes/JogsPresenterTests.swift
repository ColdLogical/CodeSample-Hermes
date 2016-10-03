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
        func testFailedDeletingJogWithAnythingShouldTellViewToShowDeleteJogFailed() {
                expectation = self.expectation(withDescription: "View show delete jog failed from failed deleting jog")
                
                presenter.failedDeletingJog()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show delete jog failed message")
                        }
                }
        }
        
        func testFailedFetchingJogsWithAnythingShouldTellViewToShowFetchingJogsFailed() {
                expectation = self.expectation(withDescription: "View show fetching jog failed from failed fetching jogs")
                
                presenter.failedFetchingJogs()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show fetching jogs failed message")
                        }
                }
        }
        
        func testPresentingJogsWithAnythinyShouldTellInteractorToFetchCurrentUser() {
                expectation = self.expectation(withDescription: "Interactor fetch current user from presenter presenting jogs")
                
                presenter.presentingJogs()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to fetch current user")
                        }
                }
        }

        // MARK: - Interactor Output
        func testDeletedJogWithCurrentUserShouldTellInteractorToFetchJogs() {
                expectation = self.expectation(withDescription: "Interactor fetch jogs from deleted jog")
                
                let user = PFUser()
                user.username = "Sarah Kerrigan"
                presenter.currentUser = user
                
                presenter.deletedJog()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to fetch jogs")
                        }
                }
        }
        
        func testFailedFetchingCurrentUserWithAnythingShouldTellWireframeToPresentLogin() {
                expectation = self.expectation(withDescription: "Wireframe presenter login from failed fetching current user")
                
                presenter.failedFetchingCurrentUser()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present login")
                        }
                }
        }
        
        func testFetchedCurrentUserWithUsernameSarahKerriganIsAdminFalseShouldTellInteractorToFetchJogsForSarahKerrigan() {
                expectation = self.expectation(withDescription: "Fetch jogs for user from fetched current user")
                
                let user = PFUser()
                user.username = "Queen of Blades"
                
                presenter.fetchedCurrentUser(user, isAdmin: false)
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to fetch jogs for user")
                        }
                }
        }
        
        func testFetchedJogsWith3JogsShouldTellViewToShow3Jogs() {
                expectation = self.expectation(withDescription: "View show jogs from fetched jogs")
                
                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()
                
                presenter.fetchedJogs([j1, j2, j3])
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show jogs")
                        }
                }
        }

        // MARK: - Presenter Interface
        func testUserTappedAddWithAnythingShouldTellWireframeToPresentAddJog() {
                expectation = self.expectation(withDescription: "Wireframe present add jog from user tapped add")
                
                presenter.userTappedAdd()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present add jog")
                        }
                }
        }
        
        func testUserTappedDeleteWithNonNilJogShouldTellInteractorToDeleteJog() {
                expectation = self.expectation(withDescription: "Interactor delete jog from user tapped delete")
                
                let jog = Jog()
                jog.distance = 314159
                
                presenter.userTappedDelete(jog)
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to delete the jog")
                        }
                }
        }
        
        func testUserTappedJogWithNonNilJogShouldTellWireframeToPresentAddJogWithTheJogTapped() {
                expectation = self.expectation(withDescription: "Wireframe present add jog with jog from user tapped jog")
                
                let jog = Jog()
                jog.distance = 314159
                
                presenter.userTappedJog(jog)
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present add jog")
                        }
                }
        }
        
        func testUserTappedLogoutWithAnythingShouldTellInteractorToLogout() {
                expectation = self.expectation(withDescription: "Interactor logout from user tapped logout")
                
                presenter.userTappedLogout()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to logout")
                        }
                }
        }
        
        func testUserTappedLogoutWithAnythingShouldTellWireframeToPresentLogin() {
                expectation = self.expectation(withDescription: "Wireframe present login from user tapped logout")
                
                presenter.userTappedLogout()
                
                waitForExpectations(timeout: 5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present login")
                        }
                }
        }

        // MARK: - Routing

        // MARK: - Interactor Input
        func deleteJog(_ jog: Jog) {
                if let exp = expectation {
                        if exp.description == "Interactor delete jog from user tapped delete" {
                                exp.fulfill()
                                
                                XCTAssertEqual(314159, jog.distance, "Jog distance should be 314159")
                        }
                }
        }
        
        func fetchCurrentUser() {
                if let exp = expectation {
                        if exp.description == "Interactor fetch current user from presenter presenting jogs" {
                                exp.fulfill()
                        }
                }
        }
        
        func fetchJogs(_ user: PFUser?) {
                if let exp = expectation {
                        if exp.description == "Fetch jogs for user from fetched current user" {
                                exp.fulfill()
                                
                                XCTAssertEqual("Queen of Blades", user!.username, "Username should be Sarah Kerrigan")
                        }
                }
                
                if let exp = expectation {
                        if exp.description == "Interactor fetch jogs from deleted jog" {
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
        func showDeleteJogFailed() {
                if let exp = expectation {
                        if exp.description == "View show delete jog failed from failed deleting jog" {
                                exp.fulfill()
                        }
                }
        }
        
        func showFetchingJogsFailed() {
                if let exp = expectation {
                        if exp.description == "View show fetching jog failed from failed fetching jogs" {
                                exp.fulfill()
                        }
                }
        }
        
        func showJogs(_ jogs: [Jog]) {
                if let exp = expectation {
                        if exp.description == "View show jogs from fetched jogs" {
                                exp.fulfill()
                                
                                XCTAssertEqual(3, jogs.count, "Jogs count should be 3")
                        }
                }
        }
        
        // MARK: - Wireframe Interface
        func presentAddJog(_ jog: Jog?) {
                if let exp = expectation {
                        if exp.description == "Wireframe present add jog from user tapped add" {
                                exp.fulfill()
                                
                                XCTAssertNil(jog, "Jog should be nil")
                        }
                }
                
                if let exp = expectation {
                        if exp.description == "Wireframe present add jog with jog from user tapped jog" {
                                exp.fulfill()
                                
                                XCTAssertEqual(314159, jog!.distance, "Jog Distance should be 314159")
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
