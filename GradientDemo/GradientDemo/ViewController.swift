//
//  ViewController.swift
//  GradientDemo
//
//  Created by Jonas Reinsch on 23.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientView = GradientView()
        gradientView.backgroundColor = UIColor.clearColor()
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientView)
        gradientView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        gradientView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        gradientView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        gradientView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
//        view.backgroundColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

