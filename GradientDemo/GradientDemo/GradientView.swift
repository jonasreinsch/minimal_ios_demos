//
//  GradientView.swift
//  GradientDemo
//
//  Created by Jonas Reinsch on 23.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override func drawRect(rect: CGRect) {

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let componentCount : Int = 2
        
        let components : [CGFloat] = [
            0,   0,   0,   0, // opaque black
            0,   0,   0,   1  // to transparent black
        ]
        
        let gradient = CGGradientCreateWithColorComponents(colorSpace, components, nil, componentCount)
        
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 0, y:CGRectGetHeight(bounds))
        
        let context = UIGraphicsGetCurrentContext()
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions(rawValue: 0))

    }


}
