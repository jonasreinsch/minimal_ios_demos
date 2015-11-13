//
//  ViewController.swift
//  AnimatedCircleDemo
//
//  Created by Jonas Reinsch on 12.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let circle = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this is just a translation of
        // David Rönnqvist's code here
        // http://stackoverflow.com/a/8021051/1269132
        // to Swift
        
        // Set up the shape of the circle
        let radius:CGFloat = 100
        
        // Make a circular shape

        circle.path = UIBezierPath(roundedRect: CGRectMake(0, 0, 2*radius,2*radius), cornerRadius:2*radius).CGPath
        // Center the shape in self.view
        circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
            CGRectGetMidY(self.view.frame)-radius)
        
        // Configure the apperence of the circle
        circle.fillColor = UIColor.clearColor().CGColor
        circle.strokeColor = UIColor.blackColor().CGColor
        circle.lineWidth = 5
        
        // Add to parent layer
        view.layer.addSublayer(circle)
        
        // Configure animation
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = 1.0 // over 2 seconds
        drawAnimation.repeatCount = 1
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawAnimation.fromValue = NSNumber(float: 0)
        drawAnimation.toValue = NSNumber(float: 1)

        // Experiment with timing to get the appearence to look the way you want
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        circle.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        circle.speed = 0
        
        // see: http://ronnqvi.st/controlling-animation-timing/
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        let widthConstraint = NSLayoutConstraint(item: slider, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.8, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: slider, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -30)
        let centerXConstraint = NSLayoutConstraint(item: slider, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        view.addConstraint(widthConstraint)
        view.addConstraint(bottomConstraint)
        view.addConstraint(centerXConstraint)
        
        slider.addTarget(self, action: "sliderChanged:", forControlEvents: .ValueChanged)
        

    }
    
    func sliderChanged(slider:UISlider) {
        print(slider.value)
        circle.timeOffset = Double(slider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

