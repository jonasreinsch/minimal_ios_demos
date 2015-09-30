//
//  ViewController.swift
//  PulsatingViewDemo
//
//  Created by Jonas Reinsch on 30.09.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.blackColor()
        
        let pv = PulsatingView()
        view.addSubview(pv)

        pv.frame = UIScreen.mainScreen().bounds
        print(pv.frame)
        pv.backgroundColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.


        

    }


}

