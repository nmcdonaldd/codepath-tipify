//
//  AppDelegate.swift
//  tipify
//
//  Created by Nick McDonald on 12/15/16.
//  Copyright © 2016 Nick McDonald. All rights reserved.
//

import UIKit

@UIApplicationMain
class tipAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUserDefaults()
        
        if (isAlpha || isBeta) {
            
            showAlphaOrBetaAlert()
            
        }
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
	
	
    // MARK: - Helper functions
    
    func setUserDefaults() {
        
        let prefs = UserDefaults.standard
        
        if (prefs.value(forKey: tipFirstTimeAppLaunch) == nil) {
            prefs.set(true, forKey: tipFirstTimeAppLaunch)
        }
    }
    
    func showAlphaOrBetaAlert() {
        
        DispatchQueue.main.async(execute: {
            
            let alphaOrBeta = isAlpha ? "Alpha" : "Beta"
            let nCharacterString = isAlpha ? "n" : ""
            
            if (UserDefaults.standard.bool(forKey: tipFirstTimeAppLaunch)) {
                
                let thisIsBetaAlertController: UIAlertController = UIAlertController(title: NSLocalizedString("Welcome to \(alphaOrBeta) Tipify!", comment: "Welcome to Beta Tipify!"), message: NSLocalizedString("This is a\(nCharacterString) \(alphaOrBeta.lowercased()) version of the app. Expect bugs, misbehaviors, crashes, etc. Please send reports to me", comment: "This is a\(nCharacterString) \(alphaOrBeta) version of the app, expect bugs, misbehaviors, crashes, etc. Please send reports to me!"), preferredStyle: .alert)
                
                let ok: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: { Void in
                    
                    thisIsBetaAlertController.dismiss(animated: true, completion: nil)
                    
                    UserDefaults.standard.set(false, forKey: tipFirstTimeAppLaunch)
                    UserDefaults.standard.synchronize()
                    
                })
                
                thisIsBetaAlertController.addAction(ok)
                
                self.window?.rootViewController?.present(thisIsBetaAlertController, animated: true, completion: nil)
            }
        })
        
    }
}

