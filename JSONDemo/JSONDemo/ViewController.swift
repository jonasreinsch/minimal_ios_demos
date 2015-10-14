//
//  ViewController.swift
//  JSONDemo
//
//  Created by Jonas Reinsch on 08.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

func jsonFromString(s:String) -> [String:String] {
    guard let data = s.dataUsingEncoding(NSUTF8StringEncoding) else {
        print("problem with the data string: \(s)")
        return [:]
    }
    
    do {
        let dict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:String]
        return dict
    } catch {
        print("json error: \(error)")
    }
    
    return [:]
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. from string literal
        let dict = jsonFromString("{\"key\": \"value\"}")
        print(dict["key"])
        
        // 2. from resource file
        if let path = NSBundle.mainBundle().pathForResource("test", ofType: "json") {
            
            do {
                let jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                
                print(jsonFromString(jsonString as String)["key"])
            }
            catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}