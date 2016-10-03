/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

import UIKit

extension UIWindow : JogsWindow {}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow? = {
                let w = UIWindow(frame: UIScreen.main.bounds)
                w.makeKeyAndVisible()
                return w
        }()
        
        lazy var jogsModule : JogsWireframe = JogsWireframe()
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
                jogsModule.presentInWindow(window!)
                
                return true
        }
}
