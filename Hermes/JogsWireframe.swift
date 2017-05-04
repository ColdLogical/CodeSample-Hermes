import UIKit

class JogsWireframe {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = JogsInteractor()
        lazy var moduleNavigationController: UINavigationController = {
                let sb = JogsWireframe.storyboard()
                let nc = (sb.instantiateViewController(withIdentifier: JogsConstants.navigationControllerIdentifier) as? UINavigationController)!
                return nc
        }()
        lazy var modulePresenter = JogsPresenter()
        lazy var moduleView: JogsView = {
                let vc = (self.moduleNavigationController.viewControllers[0] as? JogsView)!
                _ = vc.view
                return vc
        }()

        // MARK: - Computed VIPER Variables
        lazy var presenter: JogsWireframeToPresenterInterface = self.modulePresenter
        lazy var view: JogsNavigationInterface = self.moduleView

        // MARK: - Instance Variables
        var privateAddJog: AddJog?
        var addJog: AddJog {
                get {
                        if privateAddJog == nil {
                                let temp = AddJogWireframe()
                                temp.delegate = self

                                privateAddJog = temp
                        }

                        return privateAddJog!
                }
        }

        var privateLogin: Login?
        var login: Login {
                get {
                        if privateLogin == nil {
                                let l = LoginWireframe()
                                l.delegate = self

                                privateLogin = l
                        }
                        return privateLogin!
                }
        }

        // MARK: - Initialization
        init() {
                let i = moduleInteractor
                let p = modulePresenter
                let v = moduleView

                i.presenter = p

                p.interactor = i
                p.view = v
                p.wireframe = self

                v.presenter = p
        }

    	class func storyboard() -> UIStoryboard {
                return UIStoryboard(name: JogsConstants.storyboardIdentifier,
                                    bundle: Bundle(for: JogsWireframe.self))
    	}

        // MARK: - Operational

}

// MARK: - Module Interface
extension JogsWireframe: Jogs {
        var delegate: JogsDelegate? {
                get {
                        return presenter.delegate
                }
                set {
                        presenter.set(delegate: newValue)
                }
        }

        func presentJogs() {
                presenter.presentingJogs()
        }
}

// MARK: - Presenter to Wireframe Interface
extension JogsWireframe: JogsPresenterToWireframeInterface {
        func presentAdd(withJog jog: Jog?) {
                addJog.presentModally(onViewController: moduleNavigationController, withJog: jog)
        }

        func presentLogin() {
                login.presentModally(onViewController: moduleNavigationController)
        }
}

// MARK: - Add Jog Delegate
extension JogsWireframe: AddJogDelegate {
        func cancelled(addJog: AddJog) {
                addJog.dismiss()
                privateAddJog = nil
        }

        func finished(addJog: AddJog) {
                addJog.dismiss()
                privateAddJog = nil
                presenter.presentingJogs()
        }
}

// MARK: - Login Delegate
extension JogsWireframe: LoginDelegate {
        func completed(login: Login) {
                login.dismiss()
                privateLogin = nil
                presenter.presentingJogs()
        }
}
