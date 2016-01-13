//
//  ViewController.swift
//  OCRMSOxfordDemo
//
//  Created by Jonas Reinsch on 13.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

let userDefaultsApiKey = "__USER_DEFAULTS_API_KEY__"
let image = UIImage(named: "example_bc_small")!

class ViewController: UIViewController {
    
    func makeOcrRequest(apiKey:String) {
        
        guard let url = NSURL(string: "https://api.projectoxford.ai/vision/v1/ocr?language=unk&detectOrientation=true") else {
            fatalError("url seems to be invalid")
        }
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let imageData = UIImagePNGRepresentation(image)!
        let uploadTask = session.uploadTaskWithRequest(request, fromData: imageData) {
            data, response, error in
            
            do {
                guard let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject] else {
                    print("error parsing toplevel JSON dict")
                    return
                }
                
                guard let regions = dict["regions"] as? [[String:AnyObject]] else {
                    print("error extracting regions (array of dictionaries) from JSON")
                    return
                }
                
                for region in regions {
                    guard let lines = region["lines"] as? [[String:AnyObject]] else {
                        print("error extracting lines (array of dictionaries) from region")
                        return
                    }
                    
                    for line in lines {
                        guard let words = line["words"] as? [[String:AnyObject]] else {
                            print("error extracting words (array of dictionaries from line")
                            return
                        }
                        
                        for word in words {
                            guard let text = word["text"] as? String else {
                                print("error extracting text attribute of word object")
                                return
                            }
                            
                            print(text, terminator: " ")
                        }
                        print("")
                        
                    }
                }
            } catch {
                print("json error: \(error)")
            }
        }
        
        uploadTask.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAPIKeyPrompt()
    }

    var alertController:UIAlertController?
    
    func configureAPIKeyPrompt() {
        alertController = UIAlertController(title: "Enter API Key",
            message: "Please enter the API Key. Press save, then restart app.",
            preferredStyle: .Alert)
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "API Key"
        })
        
        let action = UIAlertAction(title: "Save",
            style: UIAlertActionStyle.Default,
            handler: {
                (paramAction:UIAlertAction!) in
                if let textFields = self.alertController?.textFields {
                    let theTextFields = textFields as [UITextField]
                    let enteredText = theTextFields[0].text!
                    NSUserDefaults.standardUserDefaults().setValue(enteredText, forKey: userDefaultsApiKey)
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            })
        
        alertController?.addAction(action)
        
        let cancelItem = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController?.addAction(cancelItem)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let apiKey = NSUserDefaults.standardUserDefaults().stringForKey(userDefaultsApiKey) {
            makeOcrRequest(apiKey)
        } else {
            self.presentViewController(alertController!,
                animated: true,
                completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

