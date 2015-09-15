//
//  Draggable.swift
//  DragDemo
//
//  Created by Jonas Reinsch on 14.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class Draggable: UIView {
    var leftConstraint:NSLayoutConstraint!
    var topConstraint:NSLayoutConstraint!
    let width:CGFloat = 40
    let height:CGFloat = 40
    var origin = CGPointMake(0, 0)
    
    func addDraggableConstraints() {
        self.backgroundColor = UIColor.redColor()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: width)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: height)
        leftConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: superview!, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: origin.x)
        topConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: superview!, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: origin.y)
        
        self.addConstraint(widthConstraint)
        self.addConstraint(heightConstraint)
        superview!.addConstraint(leftConstraint)
        superview!.addConstraint(topConstraint)
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
    }
    
    var startPos = CGPointMake(0, 0)
    func dragged(gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            startPos = CGPointMake(self.leftConstraint.constant,
                                   self.topConstraint.constant)
        case UIGestureRecognizerState.Changed:
            let translation:CGPoint = gestureRecognizer.translationInView(superview!)
            self.leftConstraint.constant = translation.x + startPos.x
            self.topConstraint.constant = translation.y + startPos.y
        case UIGestureRecognizerState.Ended:
            break
        default:
            break
        }
    }
}
