//
//  ViewController.swift
//  GradientDemo
//
//  Created by Jonas Reinsch on 23.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

let imageName = "moscow_city.jpg"

class ViewController: UIViewController {
    
    let dragView = UIView()
    var yConstraint:NSLayoutConstraint!
    var topConstraintGradientView:NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientView = GradientView()
        gradientView.backgroundColor = UIColor.clearColor()
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false

        let image = UIImage(named: imageName)!
        let imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
        view.addSubview(gradientView)
        gradientView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        gradientView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        topConstraintGradientView = gradientView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60)
        topConstraintGradientView.active = true
        gradientView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
        view.addSubview(dragView)
        dragView.backgroundColor = UIColor(red: 70/255, green: 130/255, blue: 180/255, alpha: 1)
        dragView.layer.cornerRadius = 20
        dragView.alpha = 0.7
        dragView.translatesAutoresizingMaskIntoConstraints = false
        dragView.widthAnchor.constraintEqualToConstant(40).active = true
        dragView.heightAnchor.constraintEqualToConstant(40).active = true
        dragView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        yConstraint = dragView.centerYAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60)
        yConstraint.active = true
        
        let pgr = UIPanGestureRecognizer(target: self, action: "panned:")
        dragView.addGestureRecognizer(pgr)
    }
    
    var startPositionY:CGFloat = 0
    func panned(pgr:UIPanGestureRecognizer) {
        switch pgr.state {
        case .Began:
            startPositionY = yConstraint.constant
        case .Changed:
            let translation = pgr.translationInView(view)
            yConstraint.constant = startPositionY + translation.y
            topConstraintGradientView.constant = startPositionY + translation.y
        case .Cancelled: break
        case .Ended: break
        case .Failed: break
        case .Possible: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

