//
//  TestWireframe.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

import UIKit

class TestWireframe : NSObject
        , TestModuleInterface
        , TestPresenterToWireframeInterface
        {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = TestInteractor()
        // Uncomment to use a navigationController from storyboard
        /*
        lazy var moduleNavigationController: UINavigationController = {
                let sb = Test.storyboard()
                let nc = sb.instantiateViewController(withIdentifier: kTestNavigationControllerIdentifier) as! UINavigationController
                return nc
        }()
        */
        lazy var modulePresenter = TestPresenter()
        lazy var moduleView: TestView = {
                // Uncomment the commented line below and delete the storyboard
                //      instantiation to use a navigationController from storyboard
                //let vc = self.moduleNavigationController.viewControllers[0] as! TestView
                
                let sb = TestWireframe.storyboard()
                let vc = sb.instantiateViewController(withIdentifier: kTestViewIdentifier) as! TestView
                
                let _ = vc.view
         
                return vc
        }()
        
        lazy var presenter : TestWireframeToPresenterInterface = self.modulePresenter
        lazy var view : TestNavigationInterface = self.moduleView

        // MARK: - Instance Variables
        var delegate: TestDelegate? {
                get {
                        return presenter.delegate
                }
                set {
                        presenter.set(newDelegate: newValue)
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
                view = v
        }

	class func storyboard() -> UIStoryboard {
                return UIStoryboard(name: kTestStoryboardIdentifier, bundle: Bundle(for: TestWireframe.self))
	}
        
        // MARK: - Operational
        
        // MARK: - Module Interface
        
        // MARK: - Wireframe Interface
        
}
