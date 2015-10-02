//
//  CircleView.swift
//  CircleDemo
//
//  Created by Jonas Reinsch on 02.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class CircleView: UIView {
    override func drawRect(rect: CGRect) {
        let c = UIGraphicsGetCurrentContext()
        let s = min(bounds.size.width, bounds.size.height)
        let squareInsideBounds = CGRectMake(1, 1, s-2, s-2)
        
        CGContextSetLineWidth(c, 2)

        CGContextSetStrokeColorWithColor(c, UIColor.redColor().CGColor)
        CGContextStrokeEllipseInRect(c, squareInsideBounds)
    }
}
