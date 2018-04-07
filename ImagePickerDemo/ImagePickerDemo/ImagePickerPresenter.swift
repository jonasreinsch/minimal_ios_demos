//
//  ImagePickerPresenter.swift
//  ImagePickerDemo
//
//  Created by Jonas Reinsch on 07.04.18.
//  Copyright © 2018 Jonas Reinsch. All rights reserved.
//

import UIKit

protocol ImagePickerPresenter where Self: UIViewController {
    func pickImageFromCamera(handlePickedImage: @escaping (UIImage) -> ())
}

extension ImagePickerPresenter {
    func pickImageFromCamera(handlePickedImage: @escaping (UIImage) -> ()) {
        ImagePickerDelegateImp.pickImageFromCamera(vc: self, handlePickedImage: handlePickedImage)
    }
}

class ImagePickerDelegateImp: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let vc:UIViewController
    let handlePickedImage: (UIImage) -> ()
    
    private init(vc:UIViewController, handlePickedImage: @escaping (UIImage) -> ()) {
        self.vc = vc
        self.handlePickedImage = handlePickedImage
    }
    
    static var instance: ImagePickerDelegateImp?
    static func pickImageFromCamera(vc: UIViewController, handlePickedImage: @escaping (UIImage) -> ()) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        
        instance = ImagePickerDelegateImp(vc: vc, handlePickedImage: handlePickedImage)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = instance
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        vc.dismiss(animated: true) {
            [unowned self]
            in
            if let image = image {
                self.handlePickedImage(image)
            }
            ImagePickerDelegateImp.instance = nil
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        vc.dismiss(animated: true) {
            ImagePickerDelegateImp.instance = nil
        }
    }
}




