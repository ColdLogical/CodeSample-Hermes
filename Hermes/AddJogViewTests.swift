//
//  AddJogViewTests.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import XCTest

@testable import Hermes

class AddJogViewTests: XCTestCase, AddJogPresenterInterface {
        var view = AddJogView()
	var window = UIWindow()
        
        // MARK: - Test Objects
        var expectation: XCTestExpectation?
        
        override func setUp() {
                super.setUp()

                let sb = UIStoryboard(name: kAddJogStoryboardIdentifier, bundle: NSBundle(forClass: AddJogView.self))
                view = sb.instantiateViewControllerWithIdentifier(kAddJogViewIdentifier) as! AddJogView
		view.loadView()
                view.presenter = self

		window.rootViewController = view
		window.makeKeyAndVisible()
        }
        
        override func tearDown() {
                super.tearDown()
		view = AddJogView()
		window = UIWindow()
                expectation = nil
        }
        
        // MARK: - Operational
        func testCancelTappedWithAnythingShouldTellPresenterUserTappedCancel() {
                expectation = expectationWithDescription("Presenter user tapped cancel from cancel tapped")
                
                view.cancelTapped(nil)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that user tapped cancel")
                        }
                }
        }
        
        func testSaveTappedWithDistance87DateApril23Time1MinuteShouldTellPresenterUserTappedSaveDistance87DateApril23Time1Minute() {
                expectation = expectationWithDescription("Presener user tapped save from save tapped")
                
                view.distanceField!.text = "8.7"
                view.datePicker!.date = NSDate(timeIntervalSince1970: 514623600)
                view.timePicker!.countDownDuration = 60;
                
                view.saveTapped(nil)
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that user tapped save")
                        }
                }
        }

        // MARK: - View Interface

        // MARK: - Presenter Interface
        func userTappedCancel() {
                if let exp = expectation {
                        if exp.description == "Presenter user tapped cancel from cancel tapped" {
                                exp.fulfill()
                        }
                }
        }
        
        func userTappedSave(jog: Jog?, distance: String, date: NSDate, time: NSTimeInterval) {
                if let exp = expectation {
                        if exp.description == "Presener user tapped save from save tapped" {
                                exp.fulfill()
                                
                                XCTAssertEqual("8.7", distance, "Distance should be 8.7")
                                XCTAssertEqual(NSDate(timeIntervalSince1970: 514623600), date, "Date should be April 23, 1986")
                                XCTAssertEqual(60, time, "Time should be 60 seconds")
                        }
                }
        }
        
}
