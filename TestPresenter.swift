//
//  TestPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 10/18/16.
//  Copyright © 2016 Cold and Logical. All rights reserved.
//

import Foundation

class TestPresenter : NSObject
        , TestInteractorToPresenterInterface
        , TestViewToPresenterInterface
        , TestWireframeToPresenterInterface
        {
        // MARK: - VIPER Stack
        weak var interactor : TestPresenterToInteractorInterface!
        weak var view : TestPresenterToViewInterface!
        weak var wireframe : TestPresenterToWireframeInterface!
        
        // MARK: - Instance Variables
        weak var delegate: TestDelegate?
        
        // MARK: - Operational
        
        // MARK: - Interactor to Presenter Interface
        
        // MARK: - View to Presenter Interface
        
        // MARK: - Wireframe to Presenter Interface
        func set(newDelegate: TestDelegate?) {
                delegate = newDelegate
        }
}
