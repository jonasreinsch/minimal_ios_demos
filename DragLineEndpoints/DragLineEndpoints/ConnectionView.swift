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
        translatesAutoresizingMaskIntoConstraints = false
        let views = ["self": self]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[self]|", options: [], metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[self]|", options: [], metrics: nil, views: views)
        superview!.addConstraints(horizontalConstraints)
        superview!.addConstraints(verticalConstraints)
    }
    
    override func drawRect(rect: CGRect) {
        let c = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(c, 2)
        CGContextSetLineCap(c, CGLineCap.Round)
        CGContextSetStrokeColorWithColor(c, UIColor.greenColor().CGColor)
        CGContextBeginPath(c)
        
        for connection in connections {
            CGContextMoveToPoint(c, connection.0.position.x+connection.0.width/2, connection.0.position.y + connection.0.height/2)
            CGContextAddLineToPoint(c, connection.1.position.x+connection.1.width/2, connection.1.position.y + connection.1.height/2)
            CGContextStrokePath(c)
        }
    }
    
    func doesConnectionExist(d1:Draggable, d2:Draggable) -> Bool {
        for connection in connections {
            if (connection.0 == d1) && (connection.1 == d2) {
                return true
            }
            if (connection.0 == d2) && (connection.1 == d1) {
                return true
            }
        }
        return false
    }
    
    func getConnectionIndex(c:Connection) -> Int {
        for var i=0; i != connections.count; ++i {
            if c.0 == connections[i].0 {
                if c.1 == connections[i].1 {
                    return i
                }
            }
            if c.0 == connections[i].1 {
                if c.1 == connections[i].0 {
                    return i
                }
            }
        }
        return -1
    }
}
