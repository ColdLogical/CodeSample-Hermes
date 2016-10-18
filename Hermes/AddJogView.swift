//
//  AddJogView.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class AddJogView : UIViewController, AddJogNavigation, AddJogPresenterToViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter : AddJogViewToPresenterInterface = AddJogPresenter()
        
        // MARK: - Instance Variables
        var currentJog: Jog?
        @IBOutlet var datePicker: UIDatePicker?
        @IBOutlet var distanceField: UITextField?
        @IBOutlet var timePicker: UIDatePicker?
        
        // MARK: - Outlets
        @IBAction func cancelTapped(_ sender: AnyObject?) {
                presenter.userTappedCancel()
        }
        
        @IBAction func saveTapped(_ sender: AnyObject?) {
                var distance = distanceField!.text
                if distance == nil {
                        distance = "0.0"
                }
                
                let date = datePicker!.date
                let time = timePicker!.countDownDuration
                
                
                presenter.userTappedSave(currentJog, distance: distance!, date: date, time: time)
        }
        
        // MARK: - Operational
        func updateFromJog(_ jog: Jog) {
                distanceField?.text = String(format: "%.2f", jog.distance ?? 0)
                datePicker?.date = jog.date ?? Date() as Date 
                timePicker?.countDownDuration = jog.time ?? 0
        }
        
        override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                
                if let cj = currentJog {
                        updateFromJog(cj)
                }
        }
        
        // MARK: - View Interface
        func showJog(_ jog: Jog) {
                currentJog = jog
                updateFromJog(jog)
        }
        
        func showSaveJogFailed() {
                let alert = UIAlertController.init(title: "Error", message: "Saving the jog failed, please try again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
}
