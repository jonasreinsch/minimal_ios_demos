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
        
        circle.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        circle.center = view.center
        view.addSubview(circle)
        
        view.backgroundColor = UIColor.black
        print(circle.frame.midX)
        print(circle.frame.midY)
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

