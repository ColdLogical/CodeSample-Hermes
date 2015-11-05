//
//  AddJogInteractor.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation

class AddJogInteractor: NSObject, AddJogInteractorInput {
        // MARK: - VIPER Stack
        lazy var presenter : AddJogInteractorOutput = AddJogPresenter()
        
        // MARK: - Instance Variables
        
        // MARK: - Operational
        func failedSavingJog(error: NSError?) {
                presenter.saveJogFailed()
        }
        
        func successSavingJog() {
                presenter.savedJog()
        }
        
        // MARK: - Interactor Input
        func saveJog(jog: Jog) {
                jog.saveInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                                self.successSavingJog()
                        } else {
                                self.failedSavingJog(error)
                        }
                }
        }
        
}