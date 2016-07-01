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

let yellowConstant = UIColor(red: 212/255, green: 169/255, blue: 47/255, alpha: 1)

class FrameView: UIView {
    let border = CAShapeLayer()
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        border.strokeColor = yellowConstant.CGColor
        border.fillColor = nil
        border.lineDashPattern = [3, 2]
        border.lineWidth = 3
        
        layer.addSublayer(border)
    }
    
    override func layoutSubviews() {
        border.path = UIBezierPath(rect: bounds).CGPath
        border.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tgr = UITapGestureRecognizer(target: self, action: "didTap")
        view.addGestureRecognizer(tgr)
    }
    
    var imagePickerObservers:[NSObjectProtocol] = []
    func didTap() {
        let imagePicker = UIImagePickerController()
        let overlay = UIView()
        let frameView = FrameView()


        let usageLabel = UILabel()
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        frameView.translatesAutoresizingMaskIntoConstraints = false
        usageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overlay.addSubview(frameView)
        overlay.addSubview(usageLabel)
        
        let guide = UILayoutGuide()
        overlay.addLayoutGuide(guide)
        guide.topAnchor.constraintEqualToAnchor(overlay.topAnchor).active = true
        guide.bottomAnchor.constraintEqualToAnchor(frameView.topAnchor).active = true
        
        usageLabel.backgroundColor = yellowConstant
        usageLabel.numberOfLines = 0
        usageLabel.text = "Tap (quickly press on screen) to focus."
        
        
        frameView.centerXAnchor.constraintEqualToAnchor(overlay.centerXAnchor).active = true
        frameView.centerYAnchor.constraintEqualToAnchor(overlay.centerYAnchor).active = true
        
        usageLabel.centerYAnchor.constraintEqualToAnchor(guide.centerYAnchor).active = true
        usageLabel.centerXAnchor.constraintEqualToAnchor(overlay.centerXAnchor).active = true
        
        // The multiplier property is not writable, therefore we prepare
        // two sets of constraints (one for each orientation) and activate
        // them accordingly. This is only necessary on iPad, because
        // the ImagePickerController does not rotate on the iPhone.
        let frameViewWidthConstraintLandscape = frameView.widthAnchor.constraintEqualToAnchor(overlay.widthAnchor, multiplier: 0.75)
        let frameViewHeightConstraintLandscape = frameView.heightAnchor.constraintEqualToAnchor(frameView.widthAnchor, multiplier: 1 / 1.545454)
        let frameViewWidthConstraintPortrait = frameView.widthAnchor.constraintEqualToAnchor(frameView.heightAnchor, multiplier: 1 / 1.545454)
        let frameViewHeightConstraintPortrait = frameView.heightAnchor.constraintEqualToAnchor(overlay.heightAnchor, multiplier: 0.75)
        
        func activateFrameViewConstraintsDependingOnOrientation() {
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                let scrb = UIScreen.mainScreen().bounds
                // I did try to use UIDevice.currentDevice().orientation
                // but it is not always synchronized with the orientation
                // of the ImagePickerController.
                if scrb.width > scrb.height { // landscape
                    frameViewWidthConstraintPortrait.active = false
                    frameViewHeightConstraintPortrait.active = false
                    frameViewWidthConstraintLandscape.active = true
                    frameViewHeightConstraintLandscape.active = true
                } else { // portrait
                    frameViewWidthConstraintLandscape.active = false
                    frameViewHeightConstraintLandscape.active = false
                    frameViewWidthConstraintPortrait.active = true
                    frameViewHeightConstraintPortrait.active = true
                }
            }
        }

        func onCapture(_:NSNotification) {
            overlay.hidden = true
        }
        func onReject(_:NSNotification) {
            overlay.hidden = false
        }

        func onOrientationChange(_:NSNotification) {
            activateFrameViewConstraintsDependingOnOrientation()
        }

        let CAPTURE = "_UIImagePickerControllerUserDidCaptureItem"
        let REJECT = "_UIImagePickerControllerUserDidRejectItem"
        let ORIENTATION = "UIDeviceOrientationDidChangeNotification"
        let ctr = NSNotificationCenter.defaultCenter()
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
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
        
        // important: the overlay views should have
        // userInteractionEnabled == true
        // otherwise, tap to focus will not work (not sure why, perhaps
        // a gesture recognizer gets added directly to them?)
        
        overlay.alpha = 0
        
        self.presentViewController(imagePicker, animated: true) {
            // important when showing the photo picker a second time,
            // since on _UIImagePickerControllerUserDidCaptureItem it gets hidden
            overlay.hidden = false
            let topOffset:CGFloat
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Pad:
                topOffset = 0
                overlay.bottomAnchor.constraintEqualToAnchor(overlay.superview!.bottomAnchor).active = true
                activateFrameViewConstraintsDependingOnOrientation()
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
            case .CarPlay:
                fatalError("not supposed to run on car play")
            }

            overlay.leadingAnchor.constraintEqualToAnchor(overlay.superview!.leadingAnchor).active = true
            overlay.trailingAnchor.constraintEqualToAnchor(overlay.superview!.trailingAnchor).active = true
            overlay.topAnchor.constraintEqualToAnchor(overlay.superview!.topAnchor, constant: topOffset).active = true
            
            UIView.animateWithDuration(0.3) {
                overlay.alpha = 1
            }
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