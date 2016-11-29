//
//  CircleView.swift
//  CircleDemo
//
//  Created by Jonas Reinsch on 02.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class CircleView: UIView {
    override func draw(_ rect: CGRect) {
        let c = UIGraphicsGetCurrentContext()
        let s = min(bounds.size.width, bounds.size.height)
        let squareInsideBounds = CGRect(x: 1, y: 1, width: s-2, height: s-2)
        
        c?.setLineWidth(2)

        c?.setStrokeColor(UIColor.red.cgColor)
        c?.strokeEllipse(in: squareInsideBounds)
    }
}
