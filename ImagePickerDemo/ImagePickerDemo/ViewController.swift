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
    let loadImageButton = UIButton(type: .Custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // layout the image view
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
        // layout the button
        view.addSubview(loadImageButton)
        loadImageButton.translatesAutoresizingMaskIntoConstraints = false
        loadImageButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: 0).active = true
        loadImageButton.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -8).active = true

        // congigure the image picker
        imagePicker.delegate = self
        
        // configure the image view
        imageView.backgroundColor = UIColor.cyanColor()
        imageView.contentMode = .ScaleAspectFit

        // configure the button
        loadImageButton.setTitle("Load Image", forState: .Normal)
        loadImageButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        loadImageButton.addTarget(self, action: "loadImageButtonTapped", forControlEvents: .TouchUpInside)
    }
    
    func loadImageButtonTapped() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    // UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

