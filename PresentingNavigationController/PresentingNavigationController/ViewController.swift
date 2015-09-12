//
//  ViewController.swift
//  PresentingNavigationController
//
//  Created by Jonas Reinsch on 11.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.redColor()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "present"))
        
    }
    
    func present() {
        let toPresent = PresentedViewController()
        let navController = UINavigationController(rootViewController: toPresent)
        presentViewController(navController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

