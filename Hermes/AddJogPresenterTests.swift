//
//  AddJogPresenterTests.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse
import XCTest

@testable import Hermes

class AddJogPresenterTests: XCTestCase, AddJogInteractorInput, AddJogViewInterface, AddJogWireframeInterface {
        var presenter = AddJogPresenter()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()
                presenter = AddJogPresenter()
                presenter.interactor = self
                presenter.view = self
                presenter.wireframe = self
        }
        
        override func tearDown() {
                super.tearDown()
		presenter = AddJogPresenter()
                expectation = nil;
        }
        
        // MARK: - Operational

        // MARK: - Interactor Output
        func testSavedJogWithAnythingShouldTellWireframeAddJogFinished() {
                expectation = expectationWithDescription("Wireframe add jog finished from saved jog")
                
                presenter.savedJog()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told that add jog finished")
                        }
                }
        }

        // MARK: - Presenter Interface
        func testUserTappedCancelWithAnythingShouldTellWireframeToCancelAddJog() {
                expectation = expectationWithDescription("Wireframe cancel add jog from presenter user tapped cancel")
                
                presenter.userTappedCancel()
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to cancel add jog")
                        }
                }
        }
        
        func testUserTappedSaveWithDistance4DateApril231986Time60ShouldTellInteractorToSaveAJogWithDistance4DateApril231986Time60() {
                expectation = expectationWithDescription("Interactor save jog from user tapped save")
                
                presenter.userTappedSave(nil, distance: "4", date: NSDate(timeIntervalSince1970: 514623600), time: 60)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to save jog")
                        }
                }
        }

        // MARK: - Routing

        // MARK: - Interactor Input
        func saveJog(jog: Jog) {
                if let exp = expectation {
                        if exp.description == "Interactor save jog from user tapped save" {
                                exp.fulfill()
                                
                                XCTAssertEqual(4, jog.distance, "Jog distance should be 4")
                                XCTAssertEqual(NSDate(timeIntervalSince1970: 514623600), jog.date, "Jog date should be April 23, 1986")
                                XCTAssertEqual(60, jog.time, "Jog time should be 60")
                        }
                }
        }
        
        // MARK: - View Interface
        func showJog(jog: Jog) {
        }
        
        // MARK: - Wireframe Interface
        func addJogFinished() {
                if let exp = expectation {
                        if exp.description == "Wireframe add jog finished from saved jog" {
                                exp.fulfill()
                        }
                }
        }
        
        func cancelAddJog() {
                if let exp = expectation {
                        if exp.description == "Wireframe cancel add jog from presenter user tapped cancel" {
                                exp.fulfill()
                        }
                }
        }
}
