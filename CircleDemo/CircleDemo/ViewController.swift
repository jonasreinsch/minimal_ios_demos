//
//  ViewController.swift
//  CircleDemo
//
//  Created by Jonas Reinsch on 02.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let circle = CircleView()
        
        circle.frame = CGRectMake(0, 0, 300, 300)
        circle.center = view.center
        view.addSubview(circle)
        
        view.backgroundColor = UIColor.blackColor()
        print(CGRectGetMidX(circle.frame))
        print(CGRectGetMidY(circle.frame))
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

