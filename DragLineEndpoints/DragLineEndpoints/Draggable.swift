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
    var position = CGPointMake(0, 0)
    var connectionView:ConnectionView?
    var viewController:ViewController?
    
    let overlapTreshold:CGFloat = 1600
    
    var workingSetConnected:Set<Draggable> = Set([])
    var workingSetDisconnected:Set<Draggable> = Set([])
    
    func addDraggableConstraints() {
        self.backgroundColor = UIColor.redColor()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: width)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: height)
        leftConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: superview!, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: position.x)
        topConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: superview!, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: position.y)
        
        self.addConstraint(widthConstraint)
        self.addConstraint(heightConstraint)
        superview!.addConstraint(leftConstraint)
        superview!.addConstraint(topConstraint)
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        let lpgr = UILongPressGestureRecognizer(target: self, action: "pressedLong:")
        lpgr.minimumPressDuration = 0.5
        self.addGestureRecognizer(lpgr)
        
        self.layer.cornerRadius = width / 2
    }
    
    func pressedLong(gestureRecognizer:UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began:
            self.userInteractionEnabled = false
            for d in viewController!.draggables {
                if self != d {
                    if connectionView!.doesConnectionExist(self, d2: d) {
                        connectionView!.connections.removeAtIndex(connectionView!.getConnectionIndex((self, d)))
                    }
                }
            }
        
            // in swift 2.0, use indexOf instead of find
            let idx = find(viewController!.draggables, self)!
            viewController!.draggables.removeAtIndex(idx)
            self.removeFromSuperview()
            connectionView!.setNeedsDisplay()

        default: println("default")
        }
    }
    
    var startPos = CGPointMake(0, 0)
    func dragged(gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            workingSetConnected = Set([])
            workingSetDisconnected = Set([])
            startPos = CGPointMake(position.x,
                                   position.y)
        case UIGestureRecognizerState.Changed:
            let translation:CGPoint = gestureRecognizer.translationInView(superview!)
            position.x = translation.x + startPos.x
            position.y = translation.y + startPos.y
            self.leftConstraint.constant = position.x
            self.topConstraint.constant = position.y
            connectionView!.setNeedsDisplay()
            
            checkOverlap()

        case UIGestureRecognizerState.Ended:
            break
        default:
            break
        }
    }
    
    func checkOverlap() {
        var x = 0
        for d in viewController!.draggables {
            if d != self {
                if (pow(position.x - d.position.x, 2) + pow(position.y - d.position.y, 2)) < overlapTreshold {
                    if connectionView!.doesConnectionExist(self, d2: d) {
                        if workingSetConnected.contains(d) {
                            continue // if just connected, do not disconnect
                        }
                        workingSetDisconnected.insert(d)
                        connectionView!.connections.removeAtIndex(connectionView!.getConnectionIndex((self, d)))
                    } else {
                        if workingSetDisconnected.contains(d) {
                            continue // if just disconnected, do not connect
                        }
                        workingSetConnected.insert(d)
                        connectionView!.connections.append((self, d))
                    }
                } else {
                    workingSetConnected.remove(d)
                    workingSetDisconnected.remove(d)
                }
            }
        }
    }
}
