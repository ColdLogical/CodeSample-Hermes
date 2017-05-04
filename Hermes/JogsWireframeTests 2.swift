//
//  JogsWireframeTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class JogsWireframeTests2: XCTestCase {

        // MARK: - JogsWindow
        var rootViewController: UIViewController? {
                willSet {
                        if let exp = expectation {
                                if exp.description == "Window set root view controller to module navigation controller" {
                                        exp.fulfill()

                                        XCTAssertEqual(newValue, wireframe.moduleNavigationController, "Root view controller should be set to the module navigation controller")
                                }
                        }
                }
        }

        // MARK: - Add Jog Module Interface
        func presentModallyOnViewController(_ viewController: AddJogModalViewController, jog: Jog?) {
                if let exp = expectation {
                        if exp.description == "Add jog module present modally on view controller from present add jog" {
                                exp.fulfill()

                                XCTAssert(viewController === wireframe.moduleNavigationController ? true : false, "View controller should be the jog navigation controller")
                        }
                }
        }

        // MARK: - Login Delegate
        func testLoginCompletedWithAnythingShouldTellThatLoginModuleToDismiss() {
                expectation = expectation(description: "Dismiss from login completed")

                wireframe.loginCompleted(self)

                XCTAssertNil(wireframe._loginModule, "Login module should be nil")

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Login module never told to dismiss")
                        }
                }
        }

        // MARK: - Add Jog Delegate
        func testAddJogCancelledWithNonNilModuleShouldTellModuleToDismissAndSetWireframeAddJogModuleToNil() {
                expectation = expectation(description: "Dismiss from add jog cancelled")

                wireframe.addJogCancelled(self)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Module never told to dismiss")
                        }
                }
        }

        func testAddJogCompleteWithNonNilModuleShouldTellModuleToDismissAndSetWireframeAddJogModuleToNil() {
                expectation = expectation(description: "Dismiss from add jog cancelled")

                wireframe.addJogComplete(self)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Module never told to dismiss")
                        }
                }
        }

        // MARK: - Login Module Interface
        func dismiss() {
                if let exp = expectation {
                        if exp.description == "Dismiss from login completed" {
                                exp.fulfill()
                        }
                }

                if let exp = expectation {
                        if exp.description == "Dismiss from add jog cancelled" {
                                exp.fulfill()
                        }
                }
        }

        func presentModallyOnViewController(_ viewController: LoginModalViewController) {
                if let exp = expectation {
                        if exp.description == "Login module present modally on view controller from present login" {
                                exp.fulfill()

                                XCTAssert(viewController === wireframe.moduleNavigationController ? true : false, "View Controller should be the jogs modules navigation controller")
                        }
                }
        }

        // MARK: - Add Jog Module Interface
        //Dismiss is already in Login Module Interface section

}
