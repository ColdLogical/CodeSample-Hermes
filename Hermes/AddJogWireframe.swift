//
//  AddJogWireframe.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class AddJogWireframe: NSObject, AddJogModuleInterface, AddJogWireframeInterface {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = AddJogInteractor()
        lazy var moduleNavigationController: UINavigationController = {
                let sb = AddJogWireframe.storyboard()
                let v = sb.instantiateViewController(withIdentifier: kAddJogNavigationControllerIdentifier) as! UINavigationController
                return v
        }()
        lazy var modulePresenter = AddJogPresenter()
        lazy var moduleView: AddJogView = {
                return self.moduleNavigationController.viewControllers[0] as! AddJogView
        }()
        lazy var presenter : AddJogRouting = self.modulePresenter
        lazy var view : AddJogNavigation = self.moduleView

        // MARK: - Instance Variables
        var delegate: AddJogDelegate?
        
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
                return UIStoryboard(name: kAddJogStoryboardIdentifier, bundle: Bundle(for: AddJogWireframe.self))
	}
        
        // MARK: - Operational
        
        // MARK: - Module Interface
        func dismiss() {
                view.dismissViewControllerAnimated(true, completion: nil)
        }
        
        func presentModallyOnViewController(_ viewController: AddJogModalViewController, jog: Jog?) {
                viewController.presentViewController(moduleNavigationController, animated: true, completion: nil);
                
                if let j = jog {
                        presenter.presentingJog(j)
                }
        }
        
        // MARK: - Wireframe Interface
        func addJogFinished() {
                if let d = delegate {
                        d.addJogComplete(self)
                }
        }
        
        func cancelAddJog() {
                if let d = delegate {
                        d.addJogCancelled(self)
                }
        }
}
