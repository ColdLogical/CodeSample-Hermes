// VIPER Interface to the Module
protocol JogsDelegate: class {

}

// VIPER Interface for communication from Interactor -> Presenter
protocol JogsInteractorToPresenterInterface: class {
        func failedDeletingJog()
        func failedFetchingCurrentUser()
        func failedFetchingJogs()
        func deletedJog()
        func fetched(user newUser: User, isAdmin: Bool)
        func fetched(jogs: [Jog])
}

// VIPER Interface for communication from View -> Presenter
protocol JogsViewToPresenterInterface: class {
        func userTappedAdd()
        func userTappedDelete(onJog jog: Jog)
        func userTapped(onJog jog: Jog)
        func userTappedLogout()
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol JogsWireframeToPresenterInterface: class {
        weak var delegate: JogsDelegate? { get }
        func set(delegate newDelegate: JogsDelegate?)

        func presentingJogs()
}
