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
    let circleView = UIView()
    let slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        
        // this is just a translation of
        // David Rönnqvist's code here
        // http://stackoverflow.com/a/8021051/1269132
        // to Swift

        // Make a circular shape
        circle.path = UIBezierPath(roundedRect: CGRect(x:0, y:0, width:2*Constants.Sizes.radius, height:2*Constants.Sizes.radius), cornerRadius:2*Constants.Sizes.radius).CGPath
        
        // Configure the appearence of the circle
        circle.fillColor = Constants.Colors.circleFill
        circle.strokeColor = Constants.Colors.circleStroke
        circle.lineWidth = Constants.Sizes.circleLineWidth
        
        // Add to parent layer
        circleView.layer.addSublayer(circle)
        
        circleView.widthAnchor.constraintEqualToConstant(2*Constants.Sizes.radius).active = true
        circleView.heightAnchor.constraintEqualToConstant(2*Constants.Sizes.radius).active = true
        circleView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        circleView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        
        
        circleView.backgroundColor = UIColor.orangeColor()
        
        // Configure animation
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = 1.0
        drawAnimation.repeatCount = 1
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawAnimation.fromValue = NSNumber(float: 0)
        drawAnimation.toValue = NSNumber(float: 1)

        // Experiment with timing to get the appearence to look the way you want
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        circle.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        circle.speed = 0
        
        // see: http://ronnqvi.st/controlling-animation-timing/
        

        configureSlider()
    }
    
    func addSubviews() {
        let views = [circleView, slider]
        
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// everything slider related in this extension
extension ViewController {
    func configureSlider() {
        layoutSlider()
        customizeSliderAppearance()
        slider.addTarget(self, action: .sliderChanged, forControlEvents: .ValueChanged)
    }
    
    func layoutSlider() {
        slider.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.8).active = true
        slider.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -30).active = true
        slider.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    func sliderChanged(slider:UISlider) {
        circle.timeOffset = Double(slider.value)
    }
    
    func customizeSliderAppearance() {
        slider.tintColor = Constants.Colors.fhViolet
        slider.thumbTintColor = Constants.Colors.fhViolet
    }
}


private extension Selector {
    static let sliderChanged = #selector(ViewController.sliderChanged)
}

struct Constants {
    struct Sizes {
        static let radius:CGFloat = 100
        static let circleLineWidth:CGFloat = 10
    }
    struct Colors {
        static let fhViolet = UIColor(red:168/255, green:4/255, blue:125/255, alpha: 1)
        static let fhBlue = UIColor(red:33/255, green:94/255, blue:151/255, alpha: 1)
        static let circleFill = UIColor.clearColor().CGColor
        static let circleStroke = fhViolet.CGColor
    }
}


