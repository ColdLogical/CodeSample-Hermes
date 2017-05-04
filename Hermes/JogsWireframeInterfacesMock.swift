@testable import Hermes

class JogsWireframeInterfacesMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
        var withJog: Jog?
}

extension JogsWireframeInterfacesMock: Jogs {
        var delegate: JogsDelegate? {
                get {
                        functionsCalled.append(#function)
                        return nil
                }
            set {
                functionsCalled.append(#function)
            }
        }
}

extension JogsWireframeInterfacesMock: JogsPresenterToWireframeInterface {
        func presentAdd(withJog jog: Jog?) {
                functionsCalled.append(#function)
                withJog = jog
        }

        func presentLogin() {
                functionsCalled.append(#function)
        }
}
