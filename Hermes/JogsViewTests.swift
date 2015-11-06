//
//  JogsViewTests.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class JogsViewTests: XCTestCase, JogsPresenterInterface {
        var view = JogsView()
	var window = UIWindow()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()

                let sb = UIStoryboard(name: kJogsStoryboardIdentifier, bundle: NSBundle(forClass: JogsView.self))
                view = sb.instantiateViewControllerWithIdentifier(kJogsViewIdentifier) as! JogsView
		view.loadView()
                view.presenter = self

		window.rootViewController = view
		window.makeKeyAndVisible()
        }
        
        override func tearDown() {
                super.tearDown()
		view = JogsView()
		window = UIWindow()
                expectation = nil
        }
        
        // MARK: - Operational
        func testAddJogsTappedWithAnythingShouldTellPresenterUserTappedAdd() {
                expectation = expectationWithDescription("Presenter user tapped add from add jogs tapped")
                
                view.addJogTapped(nil)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that user tapped add")
                        }
                }
        }
        
        func testLogoutTappedWithAnythingShouldTellPresenterUserTappedLogout() {
                expectation = expectationWithDescription("Presenter user tapped logout from logout tapped")
                
                view.logoutTapped(nil)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that user tapped logout")
                        }
                }
        }

        // MARK: - View Interface

        // MARK: - Presenter Interface
        func userTappedAdd() {
                if let exp = expectation {
                        if exp.description == "Presenter user tapped add from add jogs tapped" {
                                exp.fulfill()
                        }
                }
        }
        
        func userTappedDelete(jog: Jog) {
                
        }
        
        func userTappedJog(jog: Jog) {
                
        }
        
        func userTappedLogout() {
                if let exp = expectation {
                        if exp.description == "Presenter user tapped logout from logout tapped" {
                                exp.fulfill()
                        }
                }
        }
        
}
