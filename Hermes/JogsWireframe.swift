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
                let v = sb.instantiateViewControllerWithIdentifier(kJogsNavigationControllerIdentifier) as! UINavigationController
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
                return UIStoryboard(name: kJogsStoryboardIdentifier, bundle: NSBundle(forClass: JogsWireframe.self))
	}
        
        // MARK: - Operational
        func presentInWindow(window: JogsWindow) {
                window.rootViewController = moduleNavigationController
                presenter.presentingJogs()
        }
        
        // MARK: - Wireframe Interface
        func presentAddJog(jog: Jog?) {
                addJogModule.presentModallyOnViewController(moduleNavigationController, jog: jog)
        }
        
        func presentLogin() {
                loginModule.presentModallyOnViewController(moduleNavigationController)
        }
        
        // MARK: - Login Delegate
        func loginCompleted(loginModule: LoginModuleInterface) {
                loginModule.dismiss()
                _loginModule = nil
                presenter.presentingJogs()
        }
        
        // MARK: - Add Jog Delegate
        func addJogCancelled(addJogModule: AddJogModuleInterface) {
                addJogModule.dismiss()
                _addJogModule = nil
        }
        
        func addJogComplete(addJogModule: AddJogModuleInterface) {
                addJogModule.dismiss()
                _addJogModule = nil
                presenter.presentingJogs()
        }
}