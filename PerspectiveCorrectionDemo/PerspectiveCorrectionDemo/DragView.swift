//
//  DragView.swift
//  PerspectiveCorrectionDemo
//
//  Created by Jonas Reinsch on 11.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit
import AVFoundation

let dragViewSize:CGFloat = 150


protocol DragViewDelegate {
    func didDragTo(p:CGPoint)
}

class DragView: UIView {
    var centerXConstraint:NSLayoutConstraint!
    var centerYConstraint:NSLayoutConstraint!
    
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
        case .Changed: print("changed")
            let location = pgr.locationInView(superview)
            setPosition(CGPointMake(location.x - initialDelta.x,
                                    location.y - initialDelta.y))
        case .Ended: print("ended")
            delegate?.didDragTo(CGPointMake(centerXConstraint.constant,
                                            centerYConstraint.constant
            ))
            
        case .Failed: print("failed")
        case .Possible: print("possible")
        }
    }
    

    func setPosition(p:CGPoint) {
        guard let superview = superview else {
            fatalError("superview was nil")
        }
        if centerXConstraint == nil {
            centerXConstraint = centerXAnchor.constraintEqualToAnchor(superview.leadingAnchor)
            centerXConstraint.active = true
        }
        if centerYConstraint == nil {
            centerYConstraint = centerYAnchor.constraintEqualToAnchor(superview.topAnchor)
            centerYConstraint.active = true
        }

        centerXConstraint.constant = p.x
        centerYConstraint.constant = p.y
        
        guard let vc = delegate as? ViewController else {
            fatalError("failed cast to ViewController")
        }
        
        let operatingRect = AVMakeRectWithAspectRatioInsideRect(vc.imageView.image!.size, vc.imageView.bounds)
        
        if p.x < operatingRect.origin.x {
            centerXConstraint.constant = operatingRect.origin.x
        }
        if p.y < operatingRect.origin.y {
            centerYConstraint.constant = operatingRect.origin.y
        }
        if p.x >= operatingRect.origin.x + operatingRect.width {
            centerXConstraint.constant = operatingRect.origin.x + operatingRect.width - 1
        }
        if p.y >= operatingRect.origin.y + operatingRect.height {
            centerYConstraint.constant = operatingRect.origin.y + operatingRect.height - 1
        }
        
        


        
        
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
