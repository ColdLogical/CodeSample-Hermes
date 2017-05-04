@testable import Hermes

class JogsPresenterToViewInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
        var jogs: [Jog]?
}

extension JogsPresenterToViewInterfaceMock: JogsPresenterToViewInterface {
        func showDeleteJogFailed() {
                functionsCalled.append(#function)
        }

        func showFetchingJogsFailed() {
                functionsCalled.append(#function)
        }

        func show(jogs: [Jog]) {
                functionsCalled.append(#function)
                self.jogs = jogs
        }
}
