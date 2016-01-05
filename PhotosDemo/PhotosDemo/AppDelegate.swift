//
//  AppDelegate.swift
//  PhotosDemo
//
//  Created by Jonas Reinsch on 21.12.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        guard let window = window else {
            fatalError("window was nil in app delegate")
        }

        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSizeMake(320, 320)
        let photosCollectionViewController = PhotosCollectionViewController(collectionViewLayout: layout)

        window.rootViewController = photosCollectionViewController

        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.whiteColor()

        return true
    }
}

