//
//  ConnectionView.swift
//  DragLineEndpoints
//
//  Created by Jonas Reinsch on 16.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ConnectionView: UIView {
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
        CGContextMoveToPoint(c, 50, 50)
        CGContextAddLineToPoint(c, 1000.0, 2000.0)
        CGContextStrokePath(c)
    }
}
