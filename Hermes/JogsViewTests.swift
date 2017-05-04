import UIKit
import XCTest

@testable import Hermes

class JogsViewTests: XCTestCase {
        var view: JogsView!

        // MARK: - Test Objects
        var presenterMock: JogsViewToPresenterInterfaceMock!

        override func setUp() {
                super.setUp()

                let sb = UIStoryboard(name: Jogs.storyboardIdentifier, bundle: Bundle(for: JogsView.self))
                view = (sb.instantiateViewController(withIdentifier: Jogs.viewIdentifier) as? JogsView)!
                presenterMock = JogsViewToPresenterInterfaceMock()

                _ = view.view

                view.presenter = presenterMock
        }

        // MARK: - Operational
        func testAddJogsTappedWithAnythingShouldTellPresenterUserTappedAdd() {
                expectation = expectation(description: "Presenter user tapped add from add jogs tapped")

                view.addJogTapped(nil)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
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
                j1.date = Date(timeIntervalSince1970: 514598400)
                let j2 = Jog()
                j2.date = Date(timeIntervalSince1970: 514623600)
                let j3 = Jog()
                j3.date = Date(timeIntervalSince1970: 1000166400)
                let j4 = Jog()
                j4.date = Date(timeIntervalSince1970: 1000188000)

                view.jogs = [ j2, j4, j1, j3 ]

                view.sortJogs(false)

                XCTAssertEqual([ j4, j3, j2, j1], view.jogs, "Jogs should be sorted by date in descending order")
        }

        func testSortJogsWithAscendingTrueShouldSortJogsByAscendingDate() {
                let j1 = Jog()
                j1.date = Date(timeIntervalSince1970: 514598400)
                let j2 = Jog()
                j2.date = Date(timeIntervalSince1970: 514623600)
                let j3 = Jog()
                j3.date = Date(timeIntervalSince1970: 1000166400)
                let j4 = Jog()
                j4.date = Date(timeIntervalSince1970: 1000188000)

                view.jogs = [ j2, j4, j1, j3 ]

                view.sortJogs(true)

                XCTAssertEqual([ j1, j2, j3, j4], view.jogs, "Jogs should be sorted by date in ascending order")
        }

        func testLogoutTappedWithAnythingShouldTellPresenterUserTappedLogout() {
                expectation = expectation(description: "Presenter user tapped logout from logout tapped")

                view.logoutTapped(nil)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that user tapped logout")
                        }
                }
        }
}

// MARK: - Table View Data Source
extension JogsViewTests {
        func testTableViewCanEditRowAtIndexPathWithAnythingShouldReturnTrue() {
                let result = view.tableView(view.tableView, canEditRowAt: IndexPath.init(row: 0, section: 0))

                XCTAssertTrue(result, "Result should be true")
        }

        func testTableViewCellForRowAtIndexPathWithJogAtIndexPathShouldReturnCellProperlyConfiguredForJog() {
                let jog = Jog()
                jog.distance = 3.14
                jog.time = 60*60 // 1 hour
                jog.date = Date(timeIntervalSince1970: 514623600) //April 23, 1986 MST
                view.jogs = [jog]

                let jogCell: JogCell = (view.tableView(view.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)) as? JogCell)!

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
                j1.date = Date()

                view.jogs = [j1]

                let title = view.tableView(view.tableView, titleForFooterInSection:0)

                XCTAssertEqual("Week - Avg Sp: 3.1 / hour Dist: 314.0", title, "Title should be Week - Avg Sp: 3.1 / hour Dist: 314.0")
        }
}

// MARK: - Table View Delegate
extension JogsViewTests {
        func testTableViewDidSelectRowAtIndexPathWithJogAtIndexPathShouldTellPresenterJogWasTapped() {
                // Arrange
                let jog = Jog()
                view.jogs = [ jog ]

                // Act
                view.tableView(view.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

                // Assert
                XCTAssert(presenterMock.functiontsCalled.contains("userTapped(onJog:)"))
                XCTAssertEqual(presenterMock.onJog, jog)
        }
}

// MARK: - Presenter to View Interface
extension JogsViewTests {
        func testShowJogsWithArrayOf3JogsShouldSetViewJogsToArrayOf3Jogs() {
                // Arrange
                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()
                let jogs = [ j1, j2, j3]

                // Act
                view.showJogs(jogs)

                // Assert
                XCTAssertEqual(3, view.jogs.count)
                XCTAssert(view.jogs.contains(j1))
                XCTAssert(view.jogs.contains(j2))
                XCTAssert(view.jogs.contains(j3))
        }
}
