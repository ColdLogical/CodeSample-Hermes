@testable import Hermes

class JogsPresenterToInteractorInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
        var forUser: User?
        var jog: Jog?
}

extension JogsPresenterToInteractorInterfaceMock: JogsPresenterToInteractorInterface {
        func delete(jog: Jog) {
                functionsCalled.append(#function)
                self.jog = jog
        }

        func fetchUser() {
                functionsCalled.append(#function)
        }

        func fetchJogs(forUser user: User?) {
                functionsCalled.append(#function)
                forUser = user
        }

        func logout() {
                functionsCalled.append(#function)
        }
}
