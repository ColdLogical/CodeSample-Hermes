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
        
//        private static var __once: () = {
//                        self.registerSubclass()
//                }()
        
        @NSManaged var date: Date
        @NSManaged var distance: Double
        @NSManaged var time: TimeInterval
        @NSManaged var user: PFUser
        
//        override class func initialize() {
//                struct Static {
//                        static var onceToken : Int = 0;
//                }
//                _ = Jog.__once
//        }
        
        static func parseClassName() -> String {
                return "Jog"
        }
}
