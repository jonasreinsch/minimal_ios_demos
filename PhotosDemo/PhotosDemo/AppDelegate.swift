//
//  AppDelegate.swift
//  PhotosDemo
//
//  Created by Jonas Reinsch on 21.12.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

let screenWidth:CGFloat = UIScreen.mainScreen().bounds.width
let minimumInterItemSpacing:CGFloat = 10
let itemsInARow:Int = 3

let spacing:CGFloat = 8
let spacingInARow:CGFloat = CGFloat(itemsInARow - 1) * spacing
let imageWidth:CGFloat = (screenWidth / CGFloat(itemsInARow)) - (spacingInARow / CGFloat(itemsInARow))

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        guard let window = window else {
            fatalError("window was nil in app delegate")
        }

        let layout = UICollectionViewFlowLayout()
        
        layout.estimatedItemSize = CGSizeMake(imageWidth, imageWidth)
        
        // The InteritemSpacing is determinded entirely
        // by the (fixed) size of the cells, therefore set it to 0 here
        // (general assumption here: device orientation is portrait)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = spacing
        
        let photosCollectionViewController = PhotosCollectionViewController(collectionViewLayout: layout)

        window.rootViewController = photosCollectionViewController

        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.whiteColor()

        return true
    }
}

