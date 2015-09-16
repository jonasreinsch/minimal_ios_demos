//
//  ConnectionView.swift
//  DragLineEndpoints
//
//  Created by Jonas Reinsch on 16.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

typealias Connection = (Draggable, Draggable)

class ConnectionView: UIView {
    var connections:[Connection] = []
    
    func addLayoutConstraints() {
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        let views = ["self": self]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[self]|", options: .allZeros, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[self]|", options: .allZeros, metrics: nil, views: views)
        superview!.addConstraints(horizontalConstraints)
        superview!.addConstraints(verticalConstraints)
    }
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let c = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(c, 2)
        CGContextSetLineCap(c, kCGLineCapRound)
        CGContextSetStrokeColorWithColor(c, UIColor.greenColor().CGColor)
        CGContextBeginPath(c)
        
        for connection in connections {
            CGContextMoveToPoint(c, connection.0.position.x+connection.0.width/2, connection.0.position.y + connection.0.height/2)
            CGContextAddLineToPoint(c, connection.1.position.x+connection.1.width/2, connection.1.position.y + connection.1.height/2)
            CGContextStrokePath(c)
        }
    }
}
