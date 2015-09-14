//
//  ViewController.swift
//  DragDemo
//
//  Created by Jonas Reinsch on 12.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let draggable = UIView()
    var leftConstraint:NSLayoutConstraint!
    var topConstraint:NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.greenColor()
        
        draggable.backgroundColor = UIColor.redColor()
        draggable.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(draggable)
        
        leftConstraint = NSLayoutConstraint(item: draggable, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 100)
        topConstraint = NSLayoutConstraint(item: draggable, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 200)
        let widthConstraint = NSLayoutConstraint(item: draggable, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 200)
        let heightConstraint = NSLayoutConstraint(item: draggable, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100)
        
        draggable.addConstraint(widthConstraint)
        draggable.addConstraint(heightConstraint)
        view.addConstraint(leftConstraint)
        view.addConstraint(topConstraint)
        
        draggable.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
    }
    
    var startPos = CGPointMake(0, 0)
    func dragged(gestureRecognizer:UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            println("began")
            startPos = CGPointMake(leftConstraint.constant, topConstraint.constant)
        case UIGestureRecognizerState.Changed:
            println("changed")
            let translation:CGPoint = gestureRecognizer.translationInView(view)
            leftConstraint.constant = translation.x + startPos.x
            topConstraint.constant = translation.y + startPos.y
            
        case UIGestureRecognizerState.Ended:
            println("ended")
        default:
            println("default")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

