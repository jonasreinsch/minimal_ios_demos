//
//  LineView.swift
//  DrawLine
//
//  Created by Jonas Reinsch on 14.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class LineView: UIView {
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let c = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(c, 4)
        CGContextSetLineCap(c, kCGLineCapRound)
        CGContextSetLineDash(c, 0, [3.0, 12.0, 100], 3)
        CGContextSetStrokeColorWithColor(c, UIColor.redColor().CGColor)
        CGContextBeginPath(c)
        CGContextMoveToPoint(c, 50, 50)
        CGContextAddLineToPoint(c, 1000.0, 2000.0)
        CGContextStrokePath(c)
    }
}
