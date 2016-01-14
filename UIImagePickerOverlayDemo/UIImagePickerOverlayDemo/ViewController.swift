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
let frameView = UIView()

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
        
        overlay.addSubview(frameView)
        frameView.translatesAutoresizingMaskIntoConstraints = false
        frameView.backgroundColor = UIColor.redColor()
        
        // important: the overlay views should have
        // userInteractionEnabled == true
        // otherwise, tap to focus will not work (not sure why, perhaps
        // a gesture recognizer gets added directly to them?)

        imagePicker.cameraOverlayView = overlay

        // Not strictly needed, since kUTTypeImage
        // is the default. But better to make this explicit.
        imagePicker.mediaTypes = [kUTTypeImage as String]

        
        let tgr = UITapGestureRecognizer(target: self, action: "didTap")
        view.addGestureRecognizer(tgr)
        
    NSNotificationCenter.defaultCenter().addObserverForName("_UIImagePickerControllerUserDidCaptureItem", object:nil, queue:nil) { note in
            overlay.hidden = true
        }
    NSNotificationCenter.defaultCenter().addObserverForName("_UIImagePickerControllerUserDidRejectItem", object:nil, queue:nil) { note in
            overlay.hidden = false
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("UIDeviceOrientationDidChangeNotification", object:nil, queue:nil) { note in
            print("orientation did change: \(UIDevice.currentDevice().orientation.rawValue)")
        }
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        print(UIDevice.currentDevice().orientation)
    }
    
    
    func didTap() {
        frameView.heightAnchor.constraintEqualToAnchor(overlay.heightAnchor, multiplier: 0.8).active = true
        frameView.widthAnchor.constraintEqualToAnchor(frameView.heightAnchor, multiplier: 1 / 1.545454).active = true
        
        self.presentViewController(self.imagePicker, animated: true) {
            // important when showing the photo picker a second time,
            // since on _UIImagePickerControllerUserDidCaptureItem it gets hidden
            overlay.hidden = false
            let topOffset:CGFloat
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Pad:
                topOffset = 0
                overlay.bottomAnchor.constraintEqualToAnchor(overlay.superview!.bottomAnchor).active = true
                if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
                    frameView.widthAnchor.constraintEqualToAnchor(overlay.widthAnchor, multiplier: 0.8).active = true
                    frameView.heightAnchor.constraintEqualToAnchor(frameView.widthAnchor, multiplier: 1 / 1.545454).active = true

                }

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

            

            
            frameView.centerXAnchor.constraintEqualToAnchor(overlay.centerXAnchor).active = true
            frameView.centerYAnchor.constraintEqualToAnchor(overlay.centerYAnchor).active = true
            
            

            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

