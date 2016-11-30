//
//  Draggable.swift
//  DragDemo
//
//  Created by Jonas Reinsch on 14.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class Draggable: UIView {
    var centerXConstraint:NSLayoutConstraint!
    var centerYConstraint:NSLayoutConstraint!
    
    func addDraggableConstraints() {
        backgroundColor = UIColor.red
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: 200).isActive = true
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        centerXConstraint = centerXAnchor.constraint(equalTo: superview!.centerXAnchor)
        centerYConstraint = centerYAnchor.constraint(equalTo: superview!.centerYAnchor)
        
        centerXConstraint.isActive = true
        centerYConstraint.isActive = true
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(Draggable.dragged)))
    }
    
    var startPos = CGPoint(x: 0, y: 0)
    func dragged(_ gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.began:
            startPos = CGPoint(x: centerXConstraint.constant,
                               y: centerYConstraint.constant)
        case UIGestureRecognizerState.changed:
            let translation:CGPoint = gestureRecognizer.translation(in: superview!)
            centerXConstraint.constant = translation.x + startPos.x
            centerYConstraint.constant = translation.y + startPos.y
        case UIGestureRecognizerState.ended:
            break
        default:
            break
        }
    }
}
