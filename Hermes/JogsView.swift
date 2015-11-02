//
//  JogsView.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class JogsView : UITableViewController, JogsViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter : JogsPresenterInterface = JogsPresenter()
        
        // MARK: - Instance Variables
        
        // MARK: - Outlets
        @IBAction func addJogTapped(sender: AnyObject?) {
                presenter.userTappedAdd()
        }

        @IBAction func logoutTapped(sender: AnyObject?) {
                presenter.userTappedLogout()
        }
        
        // MARK: - Operational
        
        // MARK: - View Interface
        
}
