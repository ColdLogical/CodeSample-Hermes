//
//  JogsView.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit

class JogsView: UITableViewController, JogsPresenterToViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter: JogsViewToPresenterInterface = JogsPresenter()

}
