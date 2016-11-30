//
//  Draggable.swift
//  DragDemo
//
//  Created by Jonas Reinsch on 14.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class Draggable: UIView {
    let size:CGFloat = 50
    let innerSize:CGFloat = 30
    
    let outerColor = UIColor.clear
    let innerColor = UIColor.red
    
    var centerXConstraint:NSLayoutConstraint!
    var centerYConstraint:NSLayoutConstraint!
    
    func addDraggableConstraints() {
        backgroundColor = outerColor
        
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
        
        centerXConstraint = centerXAnchor.constraint(equalTo: superview!.centerXAnchor)
        centerYConstraint = centerYAnchor.constraint(equalTo: superview!.centerYAnchor)
        
        centerXConstraint.isActive = true
        centerYConstraint.isActive = true
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(Draggable.dragged)))
        
        clipsToBounds = true
        layer.cornerRadius = size / 2
        
        let innerCircle = UIView()
        innerCircle.backgroundColor = innerColor

        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(innerCircle)
        
        innerCircle.layer.cornerRadius = innerSize / 2
        innerCircle.clipsToBounds = true
        
        innerCircle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        innerCircle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        innerCircle.widthAnchor.constraint(equalToConstant: innerSize).isActive = true
        innerCircle.heightAnchor.constraint(equalToConstant: innerSize).isActive = true
        
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
