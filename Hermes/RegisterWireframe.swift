//
//  RegisterWireframe.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class RegisterWireframe: NSObject, RegisterModuleInterface, RegisterPresenterToWireframeInterface {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = RegisterInteractor()
        lazy var modulePresenter = RegisterPresenter()
        lazy var moduleView: RegisterView = {
                let sb = RegisterWireframe.storyboard()
                let vc = sb.instantiateViewController(withIdentifier: kRegisterViewIdentifier) as! RegisterView
                return vc
        }()
        lazy var presenter : RegisterWireframeToPresenterInterface = self.modulePresenter

        // MARK: - Instance Variables
        var delegate: RegisterDelegate?
        
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
                return UIStoryboard(name: kRegisterStoryboardIdentifier, bundle: Bundle(for: RegisterWireframe.self))
	}
        
        // MARK: - Operational
        
        // MARK: - Module Interface
        func popViewFromNavigationController(_ navigationController: RegisterNavigationController) {
//                navigationController.popViewControllerAnimated(true)
        }
        
        func pushOnNavigationController(_ navigationController: RegisterNavigationController) {
                navigationController.pushViewController(self.moduleView, animated: true)
                presenter.presenting()
        }
        
        // MARK: - Wireframe Interface
        func registrationFinished() {
                if let d = delegate {
                        d.registrationCompleted(self)
                }
        }
        
}
