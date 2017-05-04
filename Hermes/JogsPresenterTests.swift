import Foundation
import XCTest

@testable import Hermes

class JogsPresenterTests: XCTestCase {
        var presenter: JogsPresenter!

        // MARK: - Test Objects
        var delegateMock: JogsDelegateMock!
        var interactorMock: JogsPresenterToInteractorInterfaceMock!
        var viewMock: JogsPresenterToViewInterfaceMock!
        var wireframeMock: JogsWireframeInterfacesMock!

        override func setUp() {
                super.setUp()

                presenter = JogsPresenter()
                delegateMock = JogsDelegateMock()
                interactorMock = JogsPresenterToInteractorInterfaceMock()
                viewMock = JogsPresenterToViewInterfaceMock()
                wireframeMock = JogsWireframeInterfacesMock()

                presenter.delegate = delegateMock
                presenter.interactor = interactorMock
                presenter.view = viewMock
                presenter.wireframe = wireframeMock
        }

        // MARK: - Operational
        func testModuleWireframeComputedVariableWithConnectedWireframeReturnsTheWireframeAsAJogsObject() {
                // Arrange

                // Act
                let moduleWireframe = presenter.moduleWireframe

                // Assert
                XCTAssert(moduleWireframe === wireframeMock)
        }
}

// MARK: - Interactor to Presenter Interface
extension JogsPresenterTests {
        func testDeletedJogWithUserShouldTellInteractorToFetchJogs() {
                // Arrange
                let user = PFUser()
                user.username = "Sarah Kerrigan"
                presenter.currentUser = user

                // Act
                presenter.deletedJog()

                // Assert
                expect(interactorMock.functionsCalled.contains("fetchJogs()"))
        }

        func testFailedFetchingUserWithAnythingShouldTellWireframeToPresentLogin() {
                // Arrange

                // Act
                presenter.failedFetchingUser()

                // Assert
                XCTAssert(wireframeMock.functionsCalled.contains("presentLogin()"))
        }

        func testFetchedCurrentUserWithUsernameSarahKerriganIsAdminAnythingShouldTellInteractorToFetchJogsForSarahKerrigan() {
                // Arrange
                let user = PFUser()
                user.username = "Sarah Kerrigan"

                // Act
                presenter.fetched(user: user, isAdmin: false)

                // Assert
                XCTAssert(interactorMock.functionsCalled.contains("fetchJogs(forUser:)"))
                XCTAssertEqual(interactorMock.forUser, user)
        }

        func testFetchedJogsWith3JogsShouldTellViewToShow3Jogs() {
                expectation = expectation(description: "View show jogs from fetched jogs")

                let j1 = Jog()
                let j2 = Jog()
                let j3 = Jog()

                presenter.fetchedJogs([j1, j2, j3])

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("View never told to show jogs")
                        }
                }
        }

        func testFailedDeletingJogWithAnythingShouldTellViewToShowDeleteJogFailed() {
                // Arrange

                // Act
                presenter.failedDeletingJog()

                // Assert
                XCTAssert(viewMock.functionsCalled.contains("showDeleteJogFailed()"))
        }

        func testFailedFetchingJogsWithAnythingShouldTellViewToShowFetchingJogsFailed() {
                // Arrange

                // Act
                presenter.failedFetchingJogs()

                // Assert
                XCTAssert(viewMock.functionsCalled.contains("showFetchingJogsFailed()"))
        }
}

// MARK: - View to Presenter Interface
extension JogsPresenterTests {
        func testUserTappedAddWithAnythingShouldTellWireframeToPresentAddJog() {
                expectation = expectation(description: "Wireframe present add jog from user tapped add")

                presenter.userTappedAdd()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present add jog")
                        }
                }
        }

        func testUserTappedDeleteWithNonNilJogShouldTellInteractorToDeleteJog() {
                expectation = expectation(description: "Interactor delete jog from user tapped delete")

                let jog = Jog()
                jog.distance = 314159

                presenter.userTappedDelete(jog)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to delete the jog")
                        }
                }
        }

        func testUserTappedJogWithNonNilJogShouldTellWireframeToPresentAddJogWithTheJogTapped() {
                expectation = expectation(description: "Wireframe present add jog with jog from user tapped jog")

                let jog = Jog()
                jog.distance = 314159

                presenter.userTappedJog(jog)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present add jog")
                        }
                }
        }

        func testUserTappedLogoutWithAnythingShouldTellInteractorToLogout() {
                expectation = expectation(description: "Interactor logout from user tapped logout")

                presenter.userTappedLogout()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Interactor never told to logout")
                        }
                }
        }

        func testUserTappedLogoutWithAnythingShouldTellWireframeToPresentLogin() {
                expectation = expectation(description: "Wireframe present login from user tapped logout")

                presenter.userTappedLogout()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Wireframe never told to present login")
                        }
                }
        }
}

// MARK: - Wireframe to Presenter Interface
extension JogsPresenterTests {
        func testSetDelegateWithAnythingShouldSetPresentersDelegate() {
                // Arrange
                presenter.delegate = nil
                let testDelegate = JogsDelegateMock()

                // Act
                presenter.set(delegate: testDelegate)

                // Assert
                XCTAssert(presenter.delegate === testDelegate)
        }

        func testPresentingJogsWithAnythinyShouldTellInteractorToFetchUser() {
                // Arrange

                // Act
                presenter.presentingJogs()

                // Assert
                XCTAssert(interactorMock.functionsCalled.contains("fetchUser()"))
        }
}
