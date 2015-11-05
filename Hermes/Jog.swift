//
//  Jog.swift
//  Hermes
//
//  Created by Ryan Bush on 11/1/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import Foundation
import Parse

class Jog : PFObject, PFSubclassing {
        
        @NSManaged var date: NSDate
        @NSManaged var distance: Double
        @NSManaged var time: NSTimeInterval
        
        override class func initialize() {
                struct Static {
                        static var onceToken : dispatch_once_t = 0;
                }
                dispatch_once(&Static.onceToken) {
                        self.registerSubclass()
                }
        }
        
        static func parseClassName() -> String {
                return "Jog"
        }
}