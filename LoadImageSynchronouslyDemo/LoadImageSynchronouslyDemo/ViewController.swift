//
//  ViewController.swift
//  LoadImageSynchronouslyDemo
//
//  Created by Jonas Reinsch on 17.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Schloss_Neuschwanstein_2013.jpg/1200px-Schloss_Neuschwanstein_2013.jpg"
        guard let url = NSURL(string: urlString) else {
            print("invalid url string")
            return
        }
        guard let data = NSData(contentsOfURL: url) else {
            print("failure to load data from url")
            return
        }
        guard let image = UIImage(data: data) else {
            print("failure to generate an image from data")
            return
        }
        
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
        
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: imageView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

