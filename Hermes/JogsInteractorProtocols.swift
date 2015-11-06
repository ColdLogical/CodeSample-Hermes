//
//  JogsInteractorProtocols.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Parse

// VIPER Interface for communication from Presenter to Interactor
protocol JogsInteractorInput : class {
        func deleteJog(jog: Jog)
        func fetchCurrentUser()
        func fetchJogs(user: PFUser?)
        func logout()
}

protocol JogsInteractorRoleQuery {
        func getFirstObjectInBackgroundWithBlock(block: ((PFObject?, NSError?) -> Void)?)
        func whereKey(key: String, equalTo: AnyObject) -> Self
}

protocol JogsInteractorUserService {
        static func currentUser() -> PFUser?
        static func logOut()
}