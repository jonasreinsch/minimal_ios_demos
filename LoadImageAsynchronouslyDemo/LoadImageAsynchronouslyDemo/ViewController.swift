//
//  ViewController.swift
//  LoadImageAsynchronouslyDemo
//
//  Created by Jonas Reinsch on 19.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let activityIndicator = UIActivityIndicatorView()
    
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
            self.activityIndicator.stopAnimating()
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
        view.backgroundColor = UIColor.blackColor()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        let centerXConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
        view.addConstraint(centerXConstraint)
        view.addConstraint(centerYConstraint)
        
        let urlString = "https://upload.wikimedia.org/wikipedia/commons/f/f8/Schloss_Neuschwanstein_2013.jpg"

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

