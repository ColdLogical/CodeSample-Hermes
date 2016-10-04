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
        
        func userTappedSave(_ jog: Jog?, distance: String, date: Date, time: TimeInterval) {
                var currentJog: Jog
                if let j = jog {
                        currentJog = j
                } else {
                        currentJog = Jog()
                }
                
                currentJog.date = date
                currentJog.time = time
                
                if let d = Double(distance) {
                        currentJog.distance = d
                }
                
                if let u = PFUser.current() {
                        currentJog.user = u
                }
                
                interactor.saveJog(currentJog)
        }
        
        // MARK: - Routing
        func presentingJog(_ jog: Jog) {
                view.showJog(jog)
        }
}
