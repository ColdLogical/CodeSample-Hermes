//
//  AddJogPresenter.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse

class AddJogPresenter : NSObject, AddJogInteractorOutput, AddJogPresenterInterface, AddJogRouting {
        // MARK: - VIPER Stack
        lazy var interactor : AddJogInteractorInput = AddJogInteractor()
        lazy var view : AddJogViewInterface = AddJogView()
        lazy var wireframe : AddJogWireframeInterface = AddJogWireframe()
        
        // MARK: - Instance Variables
        
        // MARK: - Operational
        
        // MARK: - Interactor Output
        func saveJogFailed() {
                
        }
        
        func savedJog() {
                wireframe.addJogFinished()
        }
        
        // MARK: - Presenter Interface
        func userTappedCancel() {
                wireframe.cancelAddJog()
        }
        
        func userTappedSave(distance: String, date: NSDate, time: NSTimeInterval) {
                let newJog = Jog(className: Jog.parseClassName());
                
                if let d = Double(distance) {
                        newJog.distance = d
                }
                newJog.date = date
                newJog.time = time
                
                interactor.saveJog(newJog)
        }
        
        // MARK: - Routing
        
}
