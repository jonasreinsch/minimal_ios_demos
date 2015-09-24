//
//  ViewController.swift
//  DragRotate
//
//  Created by Jonas Reinsch on 24.09.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

// - drag a UIView
// - rotate it (around its center)
// - tap on the view to output its rotation angle and translation delta

class ViewController: UIViewController {
    let rotatingView = UIView()
    var lastTransform = CGAffineTransformIdentity
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        view.addSubview(rotatingView)
        rotatingView.backgroundColor = UIColor.orangeColor()
        rotatingView.frame = CGRectMake(0, 0, 300, 200)
        rotatingView.center = view.center
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: "didRotate:")
        rotatingView.addGestureRecognizer(rotationRecognizer)
        
        let dragRecognizer = UIPanGestureRecognizer(target: self, action: "dragged:")
        rotatingView.addGestureRecognizer(dragRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "didTap:")
        rotatingView.addGestureRecognizer(tapRecognizer)
    }
    
    func didRotate(rotationRecognizer:UIRotationGestureRecognizer) {
        switch rotationRecognizer.state {
        case .Began: lastTransform = rotatingView.transform
            fallthrough // apply the transform in .Began case,
            // too, but DRY
        case .Changed: rotatingView.transform = CGAffineTransformRotate(lastTransform, rotationRecognizer.rotation)
            
        default: break
        }
    }
    
    var startPos = CGPointMake(0, 0)
    // translate by changing the center property
    // alternatively, we could also manipulate the transform property
    func dragged(gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            startPos = rotatingView.center
        case UIGestureRecognizerState.Changed:
            let translation:CGPoint = gestureRecognizer.translationInView(view)
            rotatingView.center = CGPointMake(translation.x + startPos.x, translation.y + startPos.y)
        case UIGestureRecognizerState.Ended:
            break
        default:
            break
        }
    }
    
    func didTap(tapRecognizer:UITapGestureRecognizer) {
        // see https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreAnimation_guide/Key-ValueCodingExtensions/Key-ValueCodingExtensions.html#//apple_ref/doc/uid/TP40004514-CH12-SW1
        print("angle:", rotatingView.valueForKeyPath("layer.transform.rotation.z") as! Float)
        print("translation: \(rotatingView.center)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}