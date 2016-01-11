//
//  DragView.swift
//  PerspectiveCorrectionDemo
//
//  Created by Jonas Reinsch on 11.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

let dragViewSize:CGFloat = 150

class DragView: UIView {
    var centerXConstraint:NSLayoutConstraint!
    var centerYConstraint:NSLayoutConstraint!
    
    convenience init() {
        self.init(frame: CGRectZero)
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
        
        if p.x < 0 {
            centerXConstraint.constant = 0
        }
        if p.y < 0 {
            centerYConstraint.constant = 0
        }
        if p.x > superview.bounds.width {
            centerXConstraint.constant = superview.bounds.width - 1
        }
        if p.y > superview.bounds.height {
            centerYConstraint.constant = superview.bounds.height - 1
        }
        
        


        
        
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
