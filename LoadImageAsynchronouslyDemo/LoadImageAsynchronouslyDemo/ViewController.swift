//
//  ViewController.swift
//  LoadImageAsynchronouslyDemo
//
//  Created by Jonas Reinsch on 19.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func imageDownloadCompletionHandler(data:NSData?, response:NSURLResponse?, error:NSError?) {
        guard let data = data else {
            print("no data in response")
            return
        }
        guard let image = UIImage(data: data) else {
            print("failure to generate an image from data")
            return
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            let imageView = UIImageView(image: image)
            self.view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .ScaleAspectFit
        
            let leftConstraint = NSLayoutConstraint(item: imageView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0)
            let rightConstraint = NSLayoutConstraint(item: imageView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0)
            let topConstraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0)
        
            self.view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Schloss_Neuschwanstein_2013.jpg/1200px-Schloss_Neuschwanstein_2013.jpg"
        
        guard let url = NSURL(string: urlString) else {
            print("invalid url string")
            return
        }
        
        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithURL(url, completionHandler:imageDownloadCompletionHandler)
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

