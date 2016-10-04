//
//  JogsWireframe.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

extension UINavigationController : LoginModalViewController { }
extension UINavigationController : AddJogModalViewController { }

class JogsWireframe: NSObject, JogsWireframeInterface, LoginDelegate, AddJogDelegate {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = JogsInteractor()
        lazy var moduleNavigationController: UINavigationController = {
                let sb = JogsWireframe.storyboard()
                let v = sb.instantiateViewController(withIdentifier: kJogsNavigationControllerIdentifier) as! UINavigationController
                return v
        }()
        lazy var modulePresenter = JogsPresenter()
        lazy var moduleView: JogsView = {
                return self.moduleNavigationController.viewControllers[0] as! JogsView
        }()
        lazy var presenter : JogsRouting = self.modulePresenter

        // MARK: - Instance Variables
        var delegate: JogsDelegate?
        
        var _addJogModule : AddJogModuleInterface?
        var addJogModule: AddJogModuleInterface {
                get {
                        if _addJogModule == nil {
                                let temp = AddJogWireframe()
                                temp.delegate = self
                                
                                _addJogModule = temp
                        }
                        
                        return _addJogModule!
                }
        }
        
        var _loginModule : LoginModuleInterface?
        var loginModule : LoginModuleInterface {
                get {
                        if _loginModule == nil {
                                let l = LoginWireframe()
                                l.delegate = self
                                
                                _loginModule = l
                        }
                        return _loginModule!
                }
        }
        
        // MARK: - Initialization
        override init() {
                super.init()
                
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
                return UIStoryboard(name: kJogsStoryboardIdentifier, bundle: Bundle(for: JogsWireframe.self))
	}
        
        // MARK: - Operational
        func presentJogs() {
                presenter.presentingJogs()
        }
        
        // MARK: - Wireframe Interface
        func presentAddJog(_ jog: Jog?) {
                addJogModule.presentModallyOnViewController(moduleNavigationController, jog: jog)
        }
        
        func presentLogin() {
                loginModule.presentModallyOnViewController(moduleNavigationController)
        }
        
        // MARK: - Login Delegate
        func loginCompleted(_ loginModule: LoginModuleInterface) {
                moduleView.dismiss(animated: true, completion: nil)
                _loginModule = nil
                
                presenter.presentingJogs()
        }
        
        // MARK: - Add Jog Delegate
        func addJogCancelled(_ addJogModule: AddJogModuleInterface) {
                moduleView.dismiss(animated: true, completion: nil)
                _addJogModule = nil
        }
        
        func addJogComplete(_ addJogModule: AddJogModuleInterface) {
                addJogModule.dismiss()
                _addJogModule = nil
                presenter.presentingJogs()
        }
}
