//
//  LineView.swift
//  DrawLine
//
//  Created by Jonas Reinsch on 14.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class LineView: UIView {
    override func draw(_ rect: CGRect) {
        guard let c:CGContext = UIGraphicsGetCurrentContext() else {
            return
        }
        
        c.setLineWidth(4)
        c.setLineCap(CGLineCap.round)
        c.setLineDash(phase: 0, lengths: [3, 12, 100])
        c.setStrokeColor(UIColor.red.cgColor)
        c.beginPath()
        c.move(to: CGPoint(x: 50, y: 50))
        c.addLine(to: CGPoint(x: 1000.0, y: 2000.0))
        c.strokePath()
    }
}
