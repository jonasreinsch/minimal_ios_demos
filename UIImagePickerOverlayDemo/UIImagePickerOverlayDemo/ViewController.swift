//
//  ViewController.swift
//  UIImagePickerOverlayDemo
//
//  Created by Jonas Reinsch on 14.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit
// MobileCoreServices is needed for kUTTypeImage
import MobileCoreServices

let overlay = UIView()

class ViewController: UIViewController {
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.sourceType = .Camera
        imagePicker.allowsEditing = false
        imagePicker.cameraFlashMode = .Auto
//        imagePicker.showsCameraControls = false
        
        
        
        overlay.backgroundColor = UIColor.blueColor()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.alpha = 0.3

        imagePicker.cameraOverlayView = overlay

        print(imagePicker.cameraViewTransform)
        
        


        // Not strictly needed, since kUTTypeImage
        // is the default. But better to make this explicit.
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
//             imagePicker.delegate = self;
        
        
        let tgr = UITapGestureRecognizer(target: self, action: "didTap")
        view.addGestureRecognizer(tgr)
    }
    
    func didTap() {
        self.presentViewController(self.imagePicker, animated: true) {

            let topOffset:CGFloat
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Pad:
                topOffset = 0
                overlay.bottomAnchor.constraintEqualToAnchor(overlay.superview!.bottomAnchor).active = true
            case .Phone:
                topOffset = 44
                // height / width = 4 / 3 (aspect ratio)
                overlay.heightAnchor.constraintEqualToAnchor(overlay.widthAnchor, multiplier: 4/3).active = true
            case .TV:
                fatalError("not supposed to run on TV")
            case .Unspecified:
                fatalError("user interface idiom unspecified")
            }

            overlay.leadingAnchor.constraintEqualToAnchor(overlay.superview!.leadingAnchor).active = true
            overlay.trailingAnchor.constraintEqualToAnchor(overlay.superview!.trailingAnchor).active = true
            overlay.topAnchor.constraintEqualToAnchor(overlay.superview!.topAnchor, constant: topOffset).active = true
            
            overlay.userInteractionEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

