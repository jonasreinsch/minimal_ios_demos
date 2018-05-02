//
//  ViewController.swift
//  JSONDemo
//
//  Created by Jonas Reinsch on 08.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

func jsonFromString(s:String) -> [String:String] {
    guard let data = s.data(using: String.Encoding.utf8) else {
        print("problem with the data string: \(s)")
        return [:]
    }
    
    do {
        let dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String:String]
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
        let dict = jsonFromString(s: "{\"key\": \"value\"}")
        print(dict["key"]!)
        
        // 2. from resource file
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            
            do {
                let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                print(jsonFromString(s: jsonString)["key"] ?? "'key' not found in dictionary")
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
