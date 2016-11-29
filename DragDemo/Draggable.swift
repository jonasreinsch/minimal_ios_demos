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
    
    func addDraggableConstraints() {
        self.backgroundColor = UIColor.red
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 200)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 100)
        leftConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: superview!, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 100)
        topConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: superview!, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 200)
        
        self.addConstraint(widthConstraint)
        self.addConstraint(heightConstraint)
        superview!.addConstraint(leftConstraint)
        superview!.addConstraint(topConstraint)
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(Draggable.dragged(_:))))
    }
    
    var startPos = CGPoint(x: 0, y: 0)
    func dragged(_ gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.began:
            startPos = CGPoint(x: self.leftConstraint.constant,
                                   y: self.topConstraint.constant)
        case UIGestureRecognizerState.changed:
            let translation:CGPoint = gestureRecognizer.translation(in: superview!)
            self.leftConstraint.constant = translation.x + startPos.x
            self.topConstraint.constant = translation.y + startPos.y
        case UIGestureRecognizerState.ended:
            break
        default:
            break
        }
    }
}
