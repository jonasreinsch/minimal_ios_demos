//
//  PulsatingView.swift
//  PulsatingViewDemo
//
//  Created by Jonas Reinsch on 30.09.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class PulsatingView: UIView {
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let c = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(c, 2)

        CGContextSetStrokeColorWithColor(c, UIColor.greenColor().CGColor)
        CGContextBeginPath(c)
        CGContextMoveToPoint(c, 100, 100)
        CGContextAddLineToPoint(c, 200, 100)
        CGContextAddLineToPoint(c, 150, 200)
        CGContextClosePath(c)
        CGContextStrokePath(c)
        
        CGContextBeginPath(c)
        CGContextMoveToPoint(c, 100, 100+200)
        CGContextAddLineToPoint(c, 200, 100+200)
        CGContextAddLineToPoint(c, 150, 200+200)
        CGContextClosePath(c)
        CGContextStrokePath(c)
    }
}
