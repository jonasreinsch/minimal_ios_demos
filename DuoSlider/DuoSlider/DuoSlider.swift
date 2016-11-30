//
//  DuoSlider.swift
//  DuoSlider
//
//  Created by Jonas Reinsch on 30/11/2016.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

class DuoSlider {
    var d1:Draggable!
    var d2:Draggable!
    let line = UIView()
    let lineWidth:CGFloat = 2
    
    let containerHeight:CGFloat = 100
    
    let containerView = UIView()
    
    let label1 = UILabel()
    let label2 = UILabel()
    let labelWidth:CGFloat = 50
    
    var minYear = 1600
    var maxYear = 2006
    
    
    func addLine() {
        line.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(line)
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(label1)
        containerView.addSubview(label2)
        
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        

        label1.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        label2.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        
        label1.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: UIFontWeightBold)
        label2.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: UIFontWeightBold)
        
        label1.text = "0"
        label2.text = "0"
        
        
        label1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        label2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        label1.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        label2.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        line.backgroundColor = UIColor.blue
        line.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
        line.leadingAnchor.constraint(equalTo: label1.trailingAnchor, constant: 20).isActive = true
        line.trailingAnchor.constraint(equalTo: label2.leadingAnchor, constant: -20).isActive = true
        line.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    init() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        d1 = Draggable(duoSlider: self)
        d2 = Draggable(duoSlider: self)
        
        
        addLine()
        containerView.addSubview(d1)
        containerView.addSubview(d2)
        d1.addDraggableConstraints()
        d2.addDraggableConstraints()
    }
}
