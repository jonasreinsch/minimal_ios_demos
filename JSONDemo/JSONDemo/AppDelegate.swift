//
//  AppDelegate.swift
//  JSONDemo
//
//  Created by Jonas Reinsch on 08.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.rootViewController = ViewController()
            window.makeKeyAndVisible()
            window.backgroundColor = UIColor.white
        }
        return true
    }
}

