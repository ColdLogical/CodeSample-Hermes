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
        @IBOutlet var datePicker: UIDatePicker?
        @IBOutlet var distanceField: UITextField?
        @IBOutlet var timePicker: UIDatePicker?
        
        // MARK: - Outlets
        @IBAction func cancelTapped(sender: AnyObject) {
        
        }
        
        @IBAction func saveTapped(sender: AnyObject) {
        
        }
        
        // MARK: - Operational
        
        // MARK: - View Interface
        
}
