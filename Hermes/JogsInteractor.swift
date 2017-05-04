import Foundation

class JogsInteractor {
        // MARK: - VIPER Stack
        weak var presenter: JogsInteractorToPresenterInterface!

        // MARK: - Instance Variables

        // MARK: - Operational
        func failedDeletingJog(withError error: NSError?) {
                presenter.failedDeletingJog()
        }

        func failedFetchingJogs(withError error: NSError?) {
                presenter.failedFetchingJogs()
        }

        func successDeletingJog() {
                presenter.deletedJog()
        }

        func successFetching(jogs: [Jog]) {
                presenter.fetched(jogs: jogs)
        }
}

// MARK: - Presenter To Interactor Interface
extension JogsInteractor: JogsPresenterToInteractorInterface {
        func delete(jog: Jog) {
        }

        func fetchUser() {
        }

        func fetchJogs(forUser user: User?) {
        }

        func logout() {
        }
}
