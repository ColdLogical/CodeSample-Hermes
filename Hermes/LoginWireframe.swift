//
//  LoginWireframe.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

extension UINavigationController : RegisterNavigationController { }

class LoginWireframe: Login, LoginPresenterToWireframeInterface, RegisterDelegate {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = LoginInteractor()
        lazy var moduleNavigationController: UINavigationController = {
                let sb = LoginWireframe.storyboard()
                let v = (sb.instantiateViewController(withIdentifier: kLoginNavigationControllerIdentifier) as? UINavigationController)!
                return v
        }()
        lazy var modulePresenter = LoginPresenter()
        lazy var moduleView: LoginView = {
                return (self.moduleNavigationController.viewControllers[0] as? LoginView)!
        }()

        lazy var presenter: LoginWireframeToPresenterInterface = self.modulePresenter
        lazy var view: LoginNavigation = self.moduleView

        // MARK: - Instance Variables
        var delegate: LoginDelegate?
        lazy var registerModule: RegisterModuleInterface = {
                let r = RegisterWireframe()
                r.delegate = self
                return r
        }()

        // MARK: - Operational
        init() {
                let i = moduleInteractor
                let p = modulePresenter
                let v = moduleView

                i.presenter = p

                p.interactor = i
                p.view = v
                p.wireframe = self

                v.presenter = p

                presenter = p
        }

	class func storyboard() -> UIStoryboard {
                return UIStoryboard(name: kLoginStoryboardIdentifier, bundle: Bundle(for: LoginWireframe.self))
	}

        // MARK: - Module Interface
        func dismiss() {
                view.dismissViewControllerAnimated(true, completion: nil)
        }

        func presentModally(onViewController viewController: UIViewController) {
                viewController.present(moduleNavigationController, animated: true, completion: nil)
        }

        // MARK: - Wireframe Interface
        func loginFinished() {
                delegate?.completed(login: self)
        }

        func presentRegister() {
                registerModule.pushOnNavigationController(moduleNavigationController)
        }

        // MARK: - Register Delegate
        func registrationCompleted(_ registrationModule: RegisterModuleInterface) {
                registrationModule.popViewFromNavigationController(moduleNavigationController)
                delegate?.completed(login: self)
        }
}
