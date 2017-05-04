// VIPER Module Constants
struct JogsConstants {
        static let navigationControllerIdentifier = "JogsNavigationController"
        static let storyboardIdentifier = "Jogs"
        static let viewIdentifier = "JogsView"
}

// Interface Abstraction for working with the VIPER Module
protocol Jogs: class {
        var delegate: JogsDelegate? { get set }
        func presentJogs()
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol JogsPresenterToWireframeInterface: class {
        func presentAdd(withJog jog: Jog?)
        func presentLogin()
}
