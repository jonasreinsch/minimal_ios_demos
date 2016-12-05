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
    
    unowned var duoSlider:DuoSlider
    
    init(duoSlider: DuoSlider) {
        self.duoSlider = duoSlider
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDraggableConstraints() {
        backgroundColor = outerColor
        
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
        
        centerXConstraint = centerXAnchor.constraint(equalTo: duoSlider.line.leadingAnchor)
        centerXConstraint.isActive = true

        centerYAnchor.constraint(equalTo: duoSlider.line.centerYAnchor).isActive = true

        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(Draggable.dragged)))
        
        clipsToBounds = true
        layer.cornerRadius = size / 2
        
        let innerCircle = UIView()
        innerCircle.backgroundColor = innerColor

        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(innerCircle)
        
        innerCircle.layer.cornerRadius = innerSize / 2
        innerCircle.clipsToBounds = true
        
        innerCircle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        innerCircle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        innerCircle.widthAnchor.constraint(equalToConstant: innerSize).isActive = true
        innerCircle.heightAnchor.constraint(equalToConstant: innerSize).isActive = true
        

    }
    
    var relPos:CGFloat = 0 {
        didSet {
            print(relPos)
            if isD1 {
                let delta = Int(relPos * CGFloat(duoSlider.max - duoSlider.min))
                let newYear = delta + duoSlider.min
                duoSlider.label1.text = "\(newYear)"
            } else {
                let delta = Int(relPos * CGFloat(duoSlider.max - duoSlider.min))
                let newYear = delta + duoSlider.min
                duoSlider.label2.text = "\(newYear)"
            }
        }
    }

    func setPosition(_ p:CGFloat) {
        precondition(0 <= p && p <= 1)
        
        centerXConstraint.constant = p * duoSlider.line.bounds.width
        relPos = p
    }
    
    var isD1: Bool {
        return duoSlider.d1 == self
    }
    
    var startPos = CGPoint(x: 0, y: 0)
    func dragged(_ gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.began:
            startPos = CGPoint(x: centerXConstraint.constant,
                               y: 0)
            superview?.bringSubview(toFront: self)
        case UIGestureRecognizerState.changed:
            let translation:CGPoint = gestureRecognizer.translation(in: superview!)

            let candidateX:CGFloat = translation.x + startPos.x
            let lineLength = duoSlider.line.bounds.width
            // happy path
            var candRelPos = candidateX / lineLength
            // extreme cases, rel pos must be between 0 and 1
            if candRelPos < 0 {
                candRelPos = 0
            } else if candRelPos > 1 {
                candRelPos = 1
            }
            if isD1 {
                // non-happy path: d1 too much on the right
                if !(duoSlider.d2.centerXConstraint.constant > candidateX) {
                    candRelPos = (duoSlider.d2.centerXConstraint.constant) / lineLength
                }
            } else {
                // non-happy path: d2 too much on the left
                if !(duoSlider.d1.centerXConstraint.constant < candidateX) {
                    candRelPos = (duoSlider.d1.centerXConstraint.constant) / lineLength
                }
            }
 
            setPosition(candRelPos)
        case UIGestureRecognizerState.ended:
            break
        default:
            break
        }
    }
}
