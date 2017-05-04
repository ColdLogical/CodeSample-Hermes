import Foundation

class JogsPresenter {
        // MARK: - VIPER Stack
        weak var interactor: JogsPresenterToInteractorInterface!
        weak var view: JogsPresenterToViewInterface!
        weak var wireframe: JogsPresenterToWireframeInterface!

        // MARK: - Instance Variables
        var currentUser: User?
        var currentUserIsAdmin: Bool = false
        weak var delegate: JogsDelegate?

        // MARK: - Computed Variables
        var moduleWireframe: Jogs {
                get {
                        let mw = (self.wireframe as? Jogs)!
                        return mw
                }
        }

        // MARK: - Operational
        func fetchJogsBasedOnAdminStatus() {
                interactor.fetchJogs(forUser: currentUser)
        }
}

// MARK: - Interactor to Presenter Interface
extension JogsPresenter: JogsInteractorToPresenterInterface {
        func deletedJog() {
                fetchJogsBasedOnAdminStatus()
        }

        func failedDeletingJog() {
                view.showDeleteJogFailed()
        }

        func failedFetchingCurrentUser() {
                wireframe.presentLogin()
        }

        func failedFetchingJogs() {
                view.showFetchingJogsFailed()
        }

        func fetched(jogs: [Jog]) {
                view.show(jogs: jogs)
        }

        func fetched(user newUser: User, isAdmin: Bool) {
                currentUser = newUser
                currentUserIsAdmin = isAdmin
                fetchJogsBasedOnAdminStatus()
        }
}

// MARK: - View to Presenter Interface
extension JogsPresenter: JogsViewToPresenterInterface {
        func userTappedAdd() {
                wireframe.presentAdd(withJog: nil)
        }

        func userTappedDelete(onJog jog: Jog) {
                interactor.delete(jog: jog)
        }

        func userTapped(onJog jog: Jog) {
                wireframe.presentAdd(withJog: jog)
        }

        func userTappedLogout() {
                interactor.logout()
                wireframe.presentLogin()
        }
}

// MARK: - Wireframe to Presenter Interface
extension JogsPresenter: JogsWireframeToPresenterInterface {
        func set(delegate newDelegate: JogsDelegate?) {
                delegate = newDelegate
        }

        func presentingJogs() {
                interactor.fetchUser()
        }
}
