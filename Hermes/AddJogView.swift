//
//  AddJogView.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class AddJogView : UIViewController, AddJogNavigation, AddJogViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter : AddJogPresenterInterface = AddJogPresenter()
        
        // MARK: - Instance Variables
        var currentJog: Jog?
        @IBOutlet var datePicker: UIDatePicker?
        @IBOutlet var distanceField: UITextField?
        @IBOutlet var timePicker: UIDatePicker?
        
        // MARK: - Outlets
        @IBAction func cancelTapped(sender: AnyObject?) {
                presenter.userTappedCancel()
        }
        
        @IBAction func saveTapped(sender: AnyObject?) {
                var distance = distanceField!.text
                if distance == nil {
                        distance = "0.0"
                }
                
                let date = datePicker!.date
                let time = timePicker!.countDownDuration
                
                
                presenter.userTappedSave(currentJog, distance: distance!, date: date, time: time)
        }
        
        // MARK: - Operational
        func updateFromJog(jog: Jog) {
                distanceField?.text = String(format: "%.1f", jog.distance)
                datePicker?.date = jog.date
                timePicker?.countDownDuration = jog.time
        }
        
        override func viewWillAppear(animated: Bool) {
                super.viewWillAppear(animated)
                
                if let cj = currentJog {
                        updateFromJog(cj)
                }
        }
        
        // MARK: - View Interface
        func showJog(jog: Jog) {
                currentJog = jog
                updateFromJog(jog)
        }
}
