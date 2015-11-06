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
        
        func testSortByDateWithAnythingShouldToggleAscendingBetweenFalseAndTrue() {
                view.ascending = false
                view.sortByDate(nil)
                
                XCTAssertTrue(view.ascending, "Ascending should be true")
                
                view.ascending = true
                view.sortByDate(nil)
                
                XCTAssertFalse(view.ascending, "Ascending should be false")
        }
        
        func testSortJogsWithAscendingFalseShouldSortJogsByDescendingDate() {
                let j1 = Jog()
                j1.date = NSDate(timeIntervalSince1970: 514598400)
                let j2 = Jog()
                j2.date = NSDate(timeIntervalSince1970: 514623600)
                let j3 = Jog()
                j3.date = NSDate(timeIntervalSince1970: 1000166400)
                let j4 = Jog()
                j4.date = NSDate(timeIntervalSince1970: 1000188000)
                
                view.jogs = [ j2, j4, j1, j3 ]
                
                view.sortJogs(false)
                
                XCTAssertEqual([ j4, j3, j2, j1], view.jogs, "Jogs should be sorted by date in descending order")
        }
        
        func testSortJogsWithAscendingTrueShouldSortJogsByAscendingDate() {
                let j1 = Jog()
                j1.date = NSDate(timeIntervalSince1970: 514598400)
                let j2 = Jog()
                j2.date = NSDate(timeIntervalSince1970: 514623600)
                let j3 = Jog()
                j3.date = NSDate(timeIntervalSince1970: 1000166400)
                let j4 = Jog()
                j4.date = NSDate(timeIntervalSince1970: 1000188000)
                
                view.jogs = [ j2, j4, j1, j3 ]
                
                view.sortJogs(true)
                
                XCTAssertEqual([ j1, j2, j3, j4], view.jogs, "Jogs should be sorted by date in ascending order")
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
        
        // MARK: - Table View Data Source
        func testTableViewCanEditRowAtIndexPathWithAnythingShouldReturnTrue() {
                let result = view.tableView(view.tableView, canEditRowAtIndexPath: NSIndexPath.init(forRow: 0, inSection: 0))
                
                XCTAssertTrue(result, "Result should be true")
        }
        
        func testTableViewCellForRowAtIndexPathWithJogAtIndexPathShouldReturnCellProperlyConfiguredForJog() {
                let jog = Jog()
                jog.distance = 3.14
                jog.time = 60*60 // 1 hour
                jog.date = NSDate(timeIntervalSince1970: 514623600) //April 23, 1986 MST
                view.jogs = [jog]
                
                let jogCell: JogCell = (view.tableView(view.tableView, cellForRowAtIndexPath: NSIndexPath.init(forRow: 0, inSection: 0)) as? JogCell)!
                
                XCTAssertEqual("April 23, 1986", jogCell.dateLabel!.text, "Date text should be April 22, 1986")
                XCTAssertEqual("60 min", jogCell.timeLabel!.text, "Time text should be 60 min")
                XCTAssertEqual("3.14", jogCell.distanceLabel!.text, "Distance text should be 3.14")
                XCTAssertEqual("3.1 / hr", jogCell.averageSpeedLabel!.text, "Average speed text should be 3.1 / hr")
        }
        
        func testTableViewNumberOfRowsInSectionWith3JogsShouldReturn3() {
                view.jogs = [ Jog(), Jog(), Jog() ]
                
                let result = view.tableView(view.tableView, numberOfRowsInSection:0)
                
                XCTAssertEqual(3, result, "Result should be 3")
        }
        
        func testTableViewTitleForHeaderInSectionWithAnyJogsShouldReturnNil() {
                view.jogs = [ Jog() ]
                
                let title = view.tableView(view.tableView, titleForHeaderInSection:0)
                
                XCTAssertNil(title, "Title should be nil")
        }
       
        func testTableViewTitleForHeaderInSectionWithNoJogsShouldReturnNoJogsMessage() {
                let title = view.tableView(view.tableView, titleForHeaderInSection:0)
                
                XCTAssertEqual("Add a Jog using the + in the top right!", title, "Title when there are no jogs should be Add a Jog using the + in the top right!")
        }
        
        func testTableViewTitleForFooterInSectionWithDistance314Time100HoursShouldReturnCorrectAverageSpeedDistanceString() {
                let j1 = Jog()
                j1.distance = 314
                j1.time = 60*60*100
                j1.date = NSDate()
                
                view.jogs = [j1]
                
                let title = view.tableView(view.tableView, titleForFooterInSection:0)
                
                XCTAssertEqual("Week - Avg Sp: 3.1 / hour Dist: 314.0", title, "Title should be Week - Avg Sp: 3.1 / hour Dist: 314.0")
        }
        
        // MARK: - Table View Delegate
        func testTableViewDidSelectRowAtIndexPathWithJogAtIndexPathShouldTellPresenterJogWasTapped() {
                expectation = expectationWithDescription("Presenter user tapped jog from did select row")
                
                let j1 = Jog()
                j1.distance = 314159
                
                view.jogs = [ j1 ]
                
                view.tableView(view.tableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow: 0, inSection: 0))
                
                waitForExpectationsWithTimeout(5) {
                        (error: NSError?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told jog was tapped")
                        }
                }
        }
        
        // MARK: - View Interface
        func testShowJogsWithArrayOf3JogsShouldSetViewJogsToArrayOf3Jogs() {
                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()
                let jogs = [ j1, j2, j3]
                
                view.showJogs(jogs)
                
                XCTAssertEqual(3, view.jogs.count, "View jogs should be an array of the three jogs")
                XCTAssert(view.jogs.contains(j1), "View jogs should have j1")
                XCTAssert(view.jogs.contains(j2), "View jogs should have j2")
                XCTAssert(view.jogs.contains(j3), "View jogs should have j3")
        }

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
                if let exp = expectation {
                        if exp.description == "Presenter user tapped jog from did select row" {
                                exp.fulfill()
                                
                                XCTAssertEqual(314159, jog.distance, "Jog Distance should be 314159")
                        }
                }
        }
        
        func userTappedLogout() {
                if let exp = expectation {
                        if exp.description == "Presenter user tapped logout from logout tapped" {
                                exp.fulfill()
                        }
                }
        }
        
}
