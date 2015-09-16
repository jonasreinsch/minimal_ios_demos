//
//  ConnectionView.swift
//  DragLineEndpoints
//
//  Created by Jonas Reinsch on 16.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

typealias Connection = ((CGFloat, CGFloat), (CGFloat, CGFloat))

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
            CGContextMoveToPoint(c, connection.0.0, connection.0.1)
            CGContextAddLineToPoint(c, connection.1.0, connection.1.1)
            CGContextStrokePath(c)
        }
    }
}
