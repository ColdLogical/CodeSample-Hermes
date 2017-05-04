@testable import Hermes

class JogsViewToPresenterInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
        var onJog: Jog?
}

extension JogsViewToPresenterInterfaceMock: JogsViewToPresenterInterface {
        func userTappedAdd() {
                functionsCalled.append(#function)
        }

        func userTappedDelete(onJog jog: Jog) {
                functionsCalled.append(#function)
                onJog = jog
        }

        func userTapped(onJog jog: Jog) {
                functionsCalled.append(#function)
                onJog = jog
        }

        func userTappedLogout() {
                functionsCalled.append(#function)
        }
}
