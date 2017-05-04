// VIPER Interface for communication from Presenter to Interactor
protocol JogsPresenterToInteractorInterface: class {
        func delete(jog: Jog)
        func fetchUser()
        func fetchJogs(forUser user: User?)
        func logout()
}
