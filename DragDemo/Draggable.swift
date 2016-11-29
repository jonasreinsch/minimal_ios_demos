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
        backgroundColor = UIColor.red
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: 200).isActive = true
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        leftConstraint = leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 100)
        topConstraint = topAnchor.constraint(equalTo: superview!.topAnchor, constant: 200)
        
        leftConstraint.isActive = true
        topConstraint.isActive = true
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(Draggable.dragged)))
    }
    
    var startPos = CGPoint(x: 0, y: 0)
    func dragged(_ gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.began:
            startPos = CGPoint(x: leftConstraint.constant,
                                   y: topConstraint.constant)
        case UIGestureRecognizerState.changed:
            let translation:CGPoint = gestureRecognizer.translation(in: superview!)
            leftConstraint.constant = translation.x + startPos.x
            topConstraint.constant = translation.y + startPos.y
        case UIGestureRecognizerState.ended:
            break
        default:
            break
        }
    }
}
