@testable import Hermes

class JogsWireframeToPresenterInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
        var modifiedDelegate: JogsDelegate?

        // MARK: - Output Variables
        var delegateToReturn: JogsDelegate?
}

extension JogsWireframeToPresenterInterfaceMock: JogsWireframeToPresenterInterface {
        weak var delegate: JogsDelegate? {
                get {
                        functionsCalled.append(#function)
                        return delegateToReturn
                }
        }

        func set(delegate newDelegate: JogsDelegate?) {
                functionsCalled.append(#function)
                modifiedDelegate = newDelegate
        }

        // MARK: - Functions
        func presentingJogs() {
                functionsCalled.append(#function)
        }
}
