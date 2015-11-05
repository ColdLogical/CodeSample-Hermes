/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow? = {
                let w = UIWindow(frame: UIScreen.mainScreen().bounds)
                w.makeKeyAndVisible()
                return w
        }()
        
        lazy var jogsModule : JogsWireframe = JogsWireframe()
        
        //--------------------------------------
        // MARK: - UIApplicationDelegate
        //--------------------------------------
        
        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
                // Enable storing and querying data from Local Datastore.
                // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
                Parse.enableLocalDatastore()
                
                // ****************************************************************************
                // Uncomment this line if you want to enable Crash Reporting
                // ParseCrashReporting.enable()
                //
                // Uncomment and fill in with your Parse credentials:
                Parse.setApplicationId("Kgbtms2rnkpp1jjFh6In5F2SXmXKds7yPsHJi2L7",
                        clientKey: "GynLzoqAhtuOF2cfiqfXxw3kY5W7Seu2LzfYFTH3")
                //
                // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
                // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
                // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
                // PFFacebookUtils.initializeFacebook()
                // ****************************************************************************
                
                let defaultACL = PFACL();
                
                // If you would like all objects to be private by default, remove this line.
                defaultACL.setPublicReadAccess(true)
                defaultACL.setWriteAccess(true, forRoleWithName:"Admin")
                
                PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)
                
                if application.applicationState != UIApplicationState.Background {
                        // Track an app open here if we launch with a push, unless
                        // "content_available" was used to trigger a background push (introduced in iOS 7).
                        // In that case, we skip tracking here to avoid double counting the app-open.
                        
                        let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
                        let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
                        var noPushPayload = false;
                        if let options = launchOptions {
                                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
                        }
                        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
                                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
                        }
                }
                
                //
                //  Swift 1.2
                //
                //        if application.respondsToSelector("registerUserNotificationSettings:") {
                //            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
                //            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
                //            application.registerUserNotificationSettings(settings)
                //            application.registerForRemoteNotifications()
                //        } else {
                //            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
                //            application.registerForRemoteNotificationTypes(types)
                //        }
                
                //
                //  Swift 2.0
                //
                //        if #available(iOS 8.0, *) {
                //            let types: UIUserNotificationType = [.Alert, .Badge, .Sound]
                //            let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
                //            application.registerUserNotificationSettings(settings)
                //            application.registerForRemoteNotifications()
                //        } else {
                //            let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
                //            application.registerForRemoteNotificationTypes(types)
                //        }
                
                
                jogsModule.presentInWindow(window!)
                
//                PFUser.logInWithUsernameInBackground("admin", password: "admin") { (adminUser, error) -> Void in
//                        if let au = adminUser {
//                                let roleACL = PFACL()
//                                roleACL.setPublicWriteAccess(true)
//                                roleACL.setPublicReadAccess(true)
//                                let role = PFRole(name: "Admin", acl:roleACL)
//                                
//                                role.users.addObject(au)
//                        
//                                role.saveInBackground()
//                        }
//                }
                
                return true
        }
        
        //--------------------------------------
        // MARK: Push Notifications
        //--------------------------------------
        
        func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
                let installation = PFInstallation.currentInstallation()
                installation.setDeviceTokenFromData(deviceToken)
                installation.saveInBackground()
                
                PFPush.subscribeToChannelInBackground("") { (succeeded: Bool, error: NSError?) in
                        if succeeded {
                                print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n");
                        } else {
                                print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n", error)
                        }
                }
        }
        
        func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
                if error.code == 3010 {
                        print("Push notifications are not supported in the iOS Simulator.\n")
                } else {
                        print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
                }
        }
        
        func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
                PFPush.handlePush(userInfo)
                if application.applicationState == UIApplicationState.Inactive {
                        PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
                }
        }
}

extension UIWindow : JogsWindow {}
