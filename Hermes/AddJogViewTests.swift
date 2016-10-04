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

                let sb = UIStoryboard(name: kAddJogStoryboardIdentifier, bundle: Bundle(for: AddJogView.self))
                view = sb.instantiateViewController(withIdentifier: kAddJogViewIdentifier) as! AddJogView
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
                expectation = expectation(description: "Presenter user tapped cancel from cancel tapped")
                
                view.cancelTapped(nil)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that user tapped cancel")
                        }
                }
        }
        
        func testSaveTappedWithDistance87DateApril23Time1MinuteShouldTellPresenterUserTappedSaveDistance87DateApril23Time1Minute() {
                expectation = expectation(description: "Presener user tapped save from save tapped")
                
                view.distanceField!.text = "8.7"
                view.datePicker!.date = Date(timeIntervalSince1970: 514623600)
                view.timePicker!.countDownDuration = 60;
                
                view.saveTapped(nil)
                
                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that user tapped save")
                        }
                }
        }
        
        func testUpdateFromJogWithNonNilJogShouldUpdateTheViewCorrectly() {
                let jog = Jog()
                jog.distance = 3.14
                jog.time = 60*60 // 1 hour
                jog.date = Date(timeIntervalSince1970: 514598400) // April 23, 1986 GMT
                
                view.updateFromJog(jog)
                
                XCTAssertEqual("3.14", view.distanceField!.text, "Distance text should be 3.14")
                XCTAssertEqual(Date(timeIntervalSince1970: 514598400), view.datePicker!.date, "Distance text should be April 23, 1986 GMT")
                XCTAssertEqual(60*60, view.timePicker!.countDownDuration, "Time count down duration should be 3600")
        }

        // MARK: - View Interface
        func testShowJogWithNonNilJogShouldSetCurrentJogToJog() {
                let jog = Jog()
                jog.date = Date()
                
                view.showJog(jog)
                
                XCTAssertEqual(jog, view.currentJog!, "Current jog should be the jog passed in")
        }

        // MARK: - Presenter Interface
        func userTappedCancel() {
                if let exp = expectation {
                        if exp.description == "Presenter user tapped cancel from cancel tapped" {
                                exp.fulfill()
                        }
                }
        }
        
        func userTappedSave(_ jog: Jog?, distance: String, date: Date, time: TimeInterval) {
                if let exp = expectation {
                        if exp.description == "Presener user tapped save from save tapped" {
                                exp.fulfill()
                                
                                XCTAssertEqual("8.7", distance, "Distance should be 8.7")
                                XCTAssertEqual(Date(timeIntervalSince1970: 514623600), date, "Date should be April 23, 1986")
                                XCTAssertEqual(60, time, "Time should be 60 seconds")
                        }
                }
        }
        
}
