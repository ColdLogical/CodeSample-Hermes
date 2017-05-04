//
//  AddJogInteractorTests.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import XCTest

@testable import Hermes

class AddJogInteractorTests: XCTestCase, AddJogInteractorToPresenterInterface {
        var interactor = AddJogInteractor()

        // MARK: - Test Objects
        var expectation: XCTestExpectation?

        override func setUp() {
                super.setUp()
                interactor = AddJogInteractor()
                interactor.presenter = self
        }

        override func tearDown() {
                super.tearDown()
		interactor = AddJogInteractor()
                expectation = nil
        }

        // MARK: - Operational
        func testFailedSavingJogWithAnythingShouldTellPresenterSaveJogFailed() {
                expectation = expectation(description: "Presenter save jog failed from failed saving jog")

                interactor.failedSavingJog(nil)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told saving jog failed")
                        }
                }
        }

        func testSuccessSavingJogWithAnythingShouldTellPresenterSavedJog() {
                expectation = expectation(description: "Presenter saved jog from success saving jog")

                interactor.successSavingJog()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that jog saved")
                        }
                }
        }

        // MARK: - Interactor Input

        // MARK: - Interactor Output
        func savedJog() {
                if let exp = expectation {
                        if exp.description == "Presenter saved jog from success saving jog" {
                                exp.fulfill()
                        }
                }
        }

        func saveJogFailed() {
                if let exp = expectation {
                        if exp.description == "Presenter save jog failed from failed saving jog" {
                                exp.fulfill()
                        }
                }
        }
}
