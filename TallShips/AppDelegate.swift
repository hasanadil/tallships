//
//  AppDelegate.swift
//  TallShips
//
//  Created by Hasan Adil on 6/14/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse
import Bolts
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Fabric.with([Crashlytics()])
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("k4m0ZTMSjyOtdm5y8VM26nbBnnUAqIu5pxcHWtWg",
            clientKey: "56pOzDs37nGwT00quCVebcii7ErqpUjcUuvuYz5A")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}

