//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Jonas Reinsch on 10.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imageView = UIImageView()
    let loadImageButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // layout the image view
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // layout the button
        view.addSubview(loadImageButton)
        loadImageButton.translatesAutoresizingMaskIntoConstraints = false
        loadImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        loadImageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true


        // configure the image view
        imageView.backgroundColor = UIColor.cyan
        imageView.contentMode = .scaleAspectFit

        // configure the button
        loadImageButton.setTitle("Load Image", for: .normal)
        loadImageButton.setTitleColor(UIColor.orange, for: .normal)
        loadImageButton.addTarget(self, action: #selector(ViewController.loadImageButtonTapped), for: .touchUpInside)
    }
    
    @objc func loadImageButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        present(imagePicker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = chosenImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

