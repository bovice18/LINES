//
//  AppDelegate.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
//import FBSDKCoreKit

//import UberRides

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

   /* @available(iOS 9, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let handledUberURL = RidesAppDelegate.shared.application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation] as Any)
        
        return handledUberURL
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handledUberURL = RidesAppDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return handledUberURL
    }
 */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
        if (UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let idenfier = "Main"
            let vc = storyboard.instantiateViewController(withIdentifier: idenfier) as! UINavigationController
            self.window?.rootViewController = vc
            // App already launched
            
        } else {
            
            // This is the first launch ever
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let idenfier = "Select City"
            let vc = storyboard.instantiateViewController(withIdentifier: idenfier) as! UIViewController
            self.window?.rootViewController = vc
            
        }

     //   FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //[[FBSDKApplicationDelegate sharedInstance] application:application
        //    didFinishLaunchingWithOptions:launchOptions];
      //  return YES;
        
        /*
        // China based apps should specify the region
        Configuration.setRegion(.China)
        // If true, all requests will hit the sandbox, useful for testing
        Configuration.setSandboxEnabled(true)
        // If true, Native login will try and fallback to using Authorization Code Grant login (for privileged scopes). Otherwise will redirect to App store
        Configuration.setFallbackEnabled(false)
        // Complete other setup
 */
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
          //  FBSDKAppEvents.activateApp()
         // [FBSDKAppEvents activateApp];
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
  /*  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(_: application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
*/
    
}

