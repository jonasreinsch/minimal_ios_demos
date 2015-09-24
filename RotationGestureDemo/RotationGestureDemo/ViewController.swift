//
//  ViewController.swift
//  RotationGestureDemo
//
//  Created by Jonas Reinsch on 24.09.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let rotatingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blackColor()
        view.addSubview(rotatingView)
        rotatingView.backgroundColor = UIColor.orangeColor()
        rotatingView.frame = CGRectMake(0, 0, 300, 200)
        rotatingView.center = view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

