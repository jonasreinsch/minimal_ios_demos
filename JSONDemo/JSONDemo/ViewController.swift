//
//  ViewController.swift
//  JSONDemo
//
//  Created by Jonas Reinsch on 08.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. json data
        guard let data = "{\"bla\": \"bli\"}".dataUsingEncoding(NSUTF8StringEncoding) else {
            print("problem with the dta string")
            return
        }
        
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
            
            print(dict["bla"])
        } catch {
            print("json error: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}