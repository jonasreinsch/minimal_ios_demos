//
//  DragView.swift
//  PerspectiveCorrectionDemo
//
//  Created by Jonas Reinsch on 11.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit
import AVFoundation

let dragViewSize:CGFloat = 70
let centerViewSize:CGFloat = 3

protocol DragViewDelegate {
    func didDragTo(p:CGPoint)
}

class DragView: UIView {
    var centerXConstraint:NSLayoutConstraint!
    var centerYConstraint:NSLayoutConstraint!
    var logicalPosition:CGPoint = CGPointZero
    
    var delegate:DragViewDelegate?
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    func position() -> CGPoint {
        return CGPointMake(centerXConstraint.constant, centerYConstraint.constant)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.redColor()
        alpha = 0.5
        widthAnchor.constraintEqualToConstant(dragViewSize).active = true
        heightAnchor.constraintEqualToConstant(dragViewSize).active = true
        layer.cornerRadius = dragViewSize / 2
        
        let pgr = UIPanGestureRecognizer(target: self, action: "dragged:")
        addGestureRecognizer(pgr)
        
        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(centerView)
        
        centerView.backgroundColor = UIColor.blackColor()
        centerView.alpha = 0.7
        
        centerView.widthAnchor.constraintEqualToConstant(centerViewSize).active = true
        centerView.heightAnchor.constraintEqualToConstant(centerViewSize).active = true
        centerView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        centerView.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        
        centerView.layer.cornerRadius = centerViewSize / 2
    }
    
   var initialDelta = CGPointMake(-1000, 1000)
    func dragged(pgr:UIPanGestureRecognizer) {
        guard let superview = superview else {
            fatalError("superview was nil")
        }
        guard let centerXConstraint = centerXConstraint else {
            fatalError("centerXConstraint was nil")
        }
        guard let centerYConstraint = centerYConstraint else {
            fatalError("centerYConstraint was nil")
        }
        
        switch pgr.state {
        case .Began: print("began")
            initialDelta = CGPointMake(pgr.locationInView(superview).x - centerXConstraint.constant, pgr.locationInView(superview).y - centerYConstraint.constant)
        case .Cancelled: print("cancelled")
        case .Changed:
            let location = pgr.locationInView(superview)
            setPosition(CGPointMake(location.x - initialDelta.x,
                                    location.y - initialDelta.y))
        delegate?.didDragTo(CGPointMake(centerXConstraint.constant,
            centerYConstraint.constant
            ))
        case .Ended: print("ended")
            delegate?.didDragTo(CGPointMake(centerXConstraint.constant,
                                            centerYConstraint.constant
            ))
            
        case .Failed: print("failed")
        case .Possible: print("possible")
        }
    }
    

    func setPosition(p:CGPoint) {
        guard let imageView = superview as? UIImageView else {
            fatalError("superview was nil or not an imageView in setPosition")
        }
        guard let image = imageView.image else {
            fatalError("image was nil in setPosition")
        }
        
        if centerXConstraint == nil {
            centerXConstraint = centerXAnchor.constraintEqualToAnchor(imageView.leadingAnchor)
            centerXConstraint.active = true
        }
        if centerYConstraint == nil {
            centerYConstraint = centerYAnchor.constraintEqualToAnchor(imageView.topAnchor)
            centerYConstraint.active = true
        }


        
        let operatingRect = AVMakeRectWithAspectRatioInsideRect(image.size, imageView.bounds)
        
        
        let xPositionInImageView:CGFloat
        if p.x < operatingRect.origin.x {
            xPositionInImageView = operatingRect.origin.x
        } else if p.x >= operatingRect.origin.x + operatingRect.width {
            xPositionInImageView = operatingRect.origin.x + operatingRect.width - 1
        } else {
            xPositionInImageView = p.x
        }
        
        let yPositionInImageView:CGFloat
        if p.y < operatingRect.origin.y {
            yPositionInImageView = operatingRect.origin.y
        } else if p.y >= operatingRect.origin.y + operatingRect.height {
            yPositionInImageView = operatingRect.origin.y + operatingRect.height - 1
        } else {
            yPositionInImageView = p.y
        }
        
        centerXConstraint.constant = xPositionInImageView
        centerYConstraint.constant = yPositionInImageView
        
        logicalPosition = imageViewCoordinatesToLogicalCoordinates(CGPointMake(xPositionInImageView, yPositionInImageView), imageView: imageView)
        
        print("---------------")
        print(centerXConstraint.constant)
        print(centerYConstraint.constant)
        print(logicalPosition)
        print(imageViewCoordinatesToLogicalCoordinates(CGPointMake(xPositionInImageView, yPositionInImageView), imageView: imageView))
        print("---------------")

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
