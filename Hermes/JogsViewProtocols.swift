// VIPER Interface for manipulating the navigation of the view
protocol JogsNavigationInterface: class {

}

// VIPER Interface for communication from Presenter -> View
protocol JogsPresenterToViewInterface: class {
        func showDeleteJogFailed()
        func showFetchingJogsFailed()
        func show(jogs newJogs: [Jog])
}
