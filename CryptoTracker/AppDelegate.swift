//
//  AppDelegate.swift
//  CryptoTracker
//
//  Created by Shaikat on 29/5/21.
//  Copyright © 2021 Shayla.18. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CryptoAPIService.shared.getAllIcons()
        return true
    }
}
