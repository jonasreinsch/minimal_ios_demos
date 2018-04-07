//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Jonas Reinsch on 10.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImagePickerPresenter {
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // layout image view
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // configure image view
        imageView.backgroundColor = UIColor.darkGray
        imageView.contentMode = .scaleAspectFit
        
        let imageButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(imageButtonTapped))
        navigationItem.rightBarButtonItem = imageButton
    }
    
    @objc func imageButtonTapped() {
        pickImageFromCamera {
            [weak self]
            pickedImage in
            self?.imageView.image = pickedImage
        }
    }
}


