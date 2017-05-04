import UIKit
import XCTest

@testable import Hermes

class JogsWireframeTests: XCTestCase {
        var wireframe: JogsWireframe!

        // MARK: - Test Objects
        var presenterMock: JogsWireframeToPresenterInterfaceMock!
        var viewMock: JogsNavigationInterfaceMock!

        override func setUp() {
                super.setUp()

                wireframe = JogsWireframe()
                presenterMock = JogsWireframeToPresenterInterfaceMock()
                viewMock = JogsNavigationInterfaceMock()

                wireframe.presenter = presenterMock
                wireframe.view = viewMock
        }

        // MARK: - Init
        func testInitWithNothingShouldInstantiateVIPERStackAndConnectLayers() {
                // Arrange
                wireframe = JogsWireframe()

                // Act

                // Assert
                XCTAssertNotNil(wireframe, "Wireframe cannot be nil after init")
                XCTAssertNotNil(wireframe.moduleInteractor, "Interactor cannot be nil after init")
                XCTAssertNotNil(wireframe.modulePresenter, "Presenter cannot be nil after init")
                XCTAssertNotNil(wireframe.moduleView, "View cannot be nil after init")

                XCTAssert (wireframe.modulePresenter === wireframe.moduleInteractor.presenter ? true : false, "Interactor's presenter must be the module's presenter")

                XCTAssert(wireframe.moduleInteractor === wireframe.modulePresenter.interactor ? true : false, "Presenter's interactor must be the module's interactor")
                XCTAssert(wireframe.moduleView === wireframe.modulePresenter.view ? true : false, "Presenter's view must be the module's view")
                XCTAssert(wireframe === wireframe.modulePresenter.wireframe ? true : false, "Presenter's wireframe must be the module'swireframe")

                XCTAssert(wireframe.modulePresenter === wireframe.moduleView.presenter ? true : false, "View's presenter must be the module's presenter")

                XCTAssert(wireframe.presenter === wireframe.modulePresenter ? true : false, "Wireframe's presenter must be the module's presenter")
                XCTAssert(wireframe.view === wireframe.moduleView ? true : false, "Wireframe's view must be the module's view")
        }

        // MARK: - Class Functions
        func testStoryboardWithNothingShouldReturnStoryboardWithJogsConstantsStoryboardIdentifier() {
                // Arrange
                let storyboard = JogsWireframe.storyboard()

                // Act

                // Assert
                let storyboardName = storyboard.value(forKey: "name") as? String
                XCTAssertNotNil(storyboardName)
                XCTAssertEqual(JogsConstants.storyboardIdentifier, storyboardName, "Storyboard identifier should be the constant identifier defined in the JogsWireframeProtocols file")
        }

        // MARK: - Operational
        func testGetDelegateWithAnyDelegateShouldAskPresenterForDelegate() {
                // Arrange

                // Act
                _ = wireframe.delegate

                // Assert
                XCTAssertTrue(presenterMock.functionsCalled.contains("delegate"))
        }

        func testSetDelegateWithAnythingShouldTellPresenterToSetNewDelegate() {
                // Arrange
                let testDelegate = TestDelegateMock()

                // Act
                wireframe.delegate = testDelegate

                // Assert
                XCTAssertTrue(presenterMock.functionsCalled.contains("set(delegate:)"))
                XCTAssertTrue(presenterMock.modifiedDelegate === testDelegate)
        }
}

// MARK: - Module Interface
extension JogsWireframeTests {
        func testPresentInWindowWithAnythingShouldTellPresenterPresentingJogs() {
                expectation = expectation(description: "Presenter told presenting jogs from wireframe present in window")

                wireframe.presentJogs()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Presenter never told the module is presenting jogs")
                        }
                }
        }
}

// MARK: - Presenter to Wireframe Interface
extension JogsWireframeTests {
        func testPresentAddJogWithAnythingShouldCallAddJogModulePresentModallyOnViewController() {
                expectation = expectation(description: "Add jog module present modally on view controller from present add jog")

                wireframe._addJogModule = self

                wireframe.presentAddJog(nil)

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Add jog module never told to present modally on view controller")
                        }
                }
        }

        func testPresentLoginWithAnythingShouldTellLoginModuleToPresentModallyOnJogsModuleNavigationController() {
                expectation = expectation(description: "Login module present modally on view controller from present login")

                wireframe._loginModule = self

                wireframe.presentLogin()

                waitForExpectations(timeout: 5) {
                        (error: Error?) -> Void in
                        if error != nil {
                                XCTFail("Login Module never told to present modally")
                        }
                }
        }
}
