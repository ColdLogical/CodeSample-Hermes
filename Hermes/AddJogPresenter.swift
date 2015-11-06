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
                view.showSaveJogFailed()
        }
        
        func savedJog() {
                wireframe.addJogFinished()
        }
        
        // MARK: - Presenter Interface
        func userTappedCancel() {
                wireframe.cancelAddJog()
        }
        
        func userTappedSave(jog: Jog?, distance: String, date: NSDate, time: NSTimeInterval) {
                var currentJog: Jog
                if let j = jog {
                        currentJog = j
                } else {
                        currentJog = Jog(className: Jog.parseClassName());
                }
                
                currentJog.date = date
                currentJog.time = time
                
                if let d = Double(distance) {
                        currentJog.distance = d
                }
                
                if let u = PFUser.currentUser() {
                        currentJog.user = u
                }
                
                interactor.saveJog(currentJog)
        }
        
        // MARK: - Routing
        func presentingJog(jog: Jog) {
                view.showJog(jog)
        }
}
