//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Jonas Reinsch on 10.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    let imageView = UIImageView()
    let loadImageButton = UIButton.buttonWithType(.Custom) as! UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePicker.delegate = self
        
        let views = ["loadImageButton": loadImageButton, "imageView":imageView]
        
        
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(imageView)
        
        let horizontalConstraintsImageView = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: .allZeros, metrics: nil, views: views)
        let verticalConstraintsImageView = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: .allZeros, metrics: nil, views: views)
        
        view.addConstraints(horizontalConstraintsImageView)
        view.addConstraints(verticalConstraintsImageView)
        
        imageView.backgroundColor = UIColor.cyanColor()
        
        
        
        loadImageButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        loadImageButton.setTitle("Load Image", forState: .Normal)
        loadImageButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        loadImageButton.addTarget(self, action: "loadImageButtonTapped", forControlEvents: .TouchUpInside)
        view.addSubview(loadImageButton)
        view.backgroundColor = UIColor.whiteColor()
        

        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[loadImageButton]-|", options: .allZeros, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[loadImageButton]-|", options: .allZeros, metrics: nil, views: views)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }
    
    func loadImageButtonTapped() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

