//
//  AppDelegate.swift
//  WWCodeDFW
//
//  Created by AlkaLocal on 10/9/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //set global tab bar tint color
        UITabBar.appearance().tintColor = UIColor(red: 59/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
