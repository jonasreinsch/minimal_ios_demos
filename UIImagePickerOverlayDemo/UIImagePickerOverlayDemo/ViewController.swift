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

//
weak var overlayGlobal:UIView?
weak var frameViewGlobal:UIView?

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tgr = UITapGestureRecognizer(target: self, action: "didTap")
        view.addGestureRecognizer(tgr)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        print(UIDevice.currentDevice().orientation)
    }
    
    var imagePickerObservers:[NSObjectProtocol] = []
    func didTap() {
        let imagePicker = UIImagePickerController()
        let overlay = UIView()
        let frameView = UIView()

        func onCapture(_:NSNotification) {
            overlay.hidden = true
        }
        func onReject(_:NSNotification) {
            overlay.hidden = false
        }
        func onOrientationChange(_:NSNotification) {
            print("orientation did change: \(UIDevice.currentDevice().orientation.rawValue)")
        }
        let CAPTURE = "_UIImagePickerControllerUserDidCaptureItem"
        let REJECT = "_UIImagePickerControllerUserDidRejectItem"
        let ORIENTATION = "UIDeviceOrientationDidChangeNotification"
        let ctr = NSNotificationCenter.defaultCenter()
        imagePickerObservers = [
            ctr.addObserverForName(CAPTURE, object: nil, queue: nil, usingBlock: onCapture),
            ctr.addObserverForName(REJECT, object: nil, queue: nil, usingBlock: onReject),
            ctr.addObserverForName(ORIENTATION, object: nil, queue: nil, usingBlock: onOrientationChange)
        ]

        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.cameraOverlayView = overlay

        imagePicker.allowsEditing = false
        imagePicker.cameraFlashMode = .Auto
        //        imagePicker.showsCameraControls = false
        
        // Not strictly needed, since kUTTypeImage
        // is the default. But better to make this explicit.
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
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

        
        self.presentViewController(imagePicker, animated: true) {
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

                frameView.heightAnchor.constraintEqualToAnchor(overlay.heightAnchor, multiplier: 0.8).active = true
                frameView.widthAnchor.constraintEqualToAnchor(frameView.heightAnchor, multiplier: 1 / 1.545454).active = true

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

            print(frameView.constraints.count)
        }
    }
    
    func removeObservers() {
        let ctr = NSNotificationCenter.defaultCenter()
        for observer in imagePickerObservers {
            ctr.removeObserver(observer)
        }
        imagePickerObservers = []
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("picked image")
        dismissViewControllerAnimated(true) {
            self.removeObservers()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("did finish picking media")
        dismissViewControllerAnimated(false) {
            self.removeObservers()
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("cancel")
        dismissViewControllerAnimated(true) {
            self.removeObservers()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}