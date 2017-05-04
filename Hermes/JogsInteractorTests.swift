import Foundation
import XCTest

@testable import Hermes

class JogsInteractorTests: XCTestCase {
        var interactor: JogsInteractor!

        // MARK: - Test Objects
        var presenterMock: JogsInteractorToPresenterInterfaceMock!

        override func setUp() {
                super.setUp()

                interactor = JogsInteractor()
                presenterMock = JogsInteractorToPresenterInterfaceMock()

                interactor.presenter = presenterMock
        }

        // MARK: - Operational
        func testSuccessFetchingJogsWith3JogsShouldTellPresenterFetched3Jogs() {
                expectation = expectation(description: "Presenter fetched jogs from success fetching jogs")

                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()

                interactor.successFetchingJogs([j1, j2, j3])

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told that jogs were fetched")
                        }
                }
        }
}

// MARK: - Presenter to Interactor Interface
extension JogsInteractorTests {
        func testFetchCurrentUserWithNilCurrentUserShouldCallPresenterFailedFetchingCurrentUser() {
                expectation = expectation(description: "Presenter failed fetching current user from fetch current user")

                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsNil.self

                interactor.fetchCurrentUser()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("User Service current user never called")
                        }
                }
        }

        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryGetObjectsInBackground() {
                expectation = expectation(description: "Role query get objects in background from fetch current user")

                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
                //                interactor.roleQuery = self

                interactor.fetchCurrentUser()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to get objects in background")
                        }
                }
        }

        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryWhereKeyNameEqualToAdmin() {
                expectation = expectation(description: "Role query where key name equal to admin from fetch current user")

                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
                //                interactor.roleQuery = self

                interactor.fetchCurrentUser()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to set name to admin")
                        }
                }
        }

        func testFetchCurrentUserWithNonNilCurrentUserShouldCallRoleQueryWhereKeyUsersEqualToCurrentUser() {
                expectation = expectation(description: "Role query where key user equal to current user from fetch current user")

                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsUser.self
                //                interactor.roleQuery = self

                interactor.fetchCurrentUser()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Role query never told to set user to current user")
                        }
                }
        }

        func testLogoutWithAnythingShouldTellUserServiceToLogOut() {
                expectation = expectation(description: "User service log out from logout")

                interactor.userService = JogsInteractorUserServiceCurrentUserReturnsNil.self
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(JogsInteractorTests.receivedNotification(_:)),
                                                       name: NSNotification.Name(rawValue: "User service log out from logout"),
                                                       object: nil)

                interactor.logout()

                NotificationCenter.default.removeObserver(self)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("User service never told to log out")
                        }
                }
        }
}
