//
//  ViewController.swift
//  RotateImageAnimated
//
//  Created by Jonas Reinsch on 18.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    var rotationIndex:Int = 0
    let rotations = [0, M_PI_2, M_PI, 3 * M_PI_2]
    
    var imgView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        
        
        guard let image = UIImage(named: "test_image.jpg") else {
            fatalError("image file doesn't seem to exist")
        }
        let imageView = UIImageView(image: image)
        imgView = imageView

        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        imageView.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.7).active = true
        imageView.widthAnchor.constraintEqualToAnchor(imageView.heightAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 20)
        imageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        
        imageView.contentMode = .ScaleAspectFit
        
        imageView.backgroundColor = UIColor.blackColor()
        
        
        
        let rotateLeftButton = UIButton(type: .Custom)
        let rotateRightButton = UIButton(type: .Custom)
        view.addSubview(rotateLeftButton)
        view.addSubview(rotateRightButton)
        
        rotateLeftButton.translatesAutoresizingMaskIntoConstraints = false
        rotateRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        rotateLeftButton.setTitle("Rotate ↺", forState: .Normal)
        rotateRightButton.setTitle("↻ Rotate", forState: .Normal)
        
        rotateLeftButton.topAnchor.constraintEqualToAnchor(imageView.bottomAnchor, constant: 20).active = true
        rotateLeftButton.trailingAnchor.constraintEqualToAnchor(imageView.centerXAnchor, constant: -40).active = true
        
        rotateRightButton.topAnchor.constraintEqualToAnchor(imageView.bottomAnchor, constant: 20).active = true
        rotateRightButton.leftAnchor.constraintEqualToAnchor(imageView.centerXAnchor, constant: 40).active = true
        
        rotateRightButton.addTarget(self, action: "rotateClockwise", forControlEvents: .TouchUpInside)
        rotateLeftButton.addTarget(self, action: "rotateCounterclockwise", forControlEvents: .TouchUpInside)
        
        
    }
    
    func rotateClockwise() {
        guard let imgView = imgView else {
            print("imgView is not initialized")
            return
        }
        rotationIndex = (1 + rotationIndex) % 4
        let rotationAngle = rotations[rotationIndex]
        let transform = CGAffineTransformMakeRotation(CGFloat(rotationAngle))
        UIView.animateWithDuration(0.3) {
            imgView.transform = transform
        }
    }
    
    func rotateCounterclockwise() {
        guard let imgView = imgView else {
            print("imgView is not initialized")
            return
        }
        rotationIndex = (rotationIndex - 1) % 4
        if rotationIndex < 0 {
            rotationIndex = 3
        }
        let rotationAngle = rotations[rotationIndex]
        let transform = CGAffineTransformMakeRotation(CGFloat(rotationAngle))
        UIView.animateWithDuration(0.3) {
            imgView.transform = transform
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

