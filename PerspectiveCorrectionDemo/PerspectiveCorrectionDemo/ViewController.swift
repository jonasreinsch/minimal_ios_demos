//
//  ViewController.swift
//  PerspectiveCorrectionDemo
//
//  Created by Jonas Reinsch on 11.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func testCrop() -> CGImage {
        
        let ciInputImage = CIImage(image:UIImage(named:"test_image.jpg")!)
        
        print("source image is \(ciInputImage)") //<CIImage: 0x170212290 extent [0 0 1024 1024]>
        
        let ptBotLeft = CGPointMake(32.0,32.0)
        let ptBotRight = CGPointMake(992.0,40.0)
        let ptTopRight = CGPointMake(800.0,700.0)
        let ptTopLeft = CGPointMake(32.0,700.0)
        
        let croppedImage = _getCroppedImageWithImage(ciInputImage!, topLeft: ptTopLeft, topRight: ptTopRight, botLeft: ptBotLeft, botRight: ptBotRight)
        print("cropped image \(croppedImage)") //<CIImage: 0x174204a60 extent [0 0 960 960]>
        
        let croppedImageCG = CIContext(options: nil).createCGImage(croppedImage, fromRect: croppedImage.extent)
        
        return croppedImageCG
        
//        let imageVC = ImageViewController(image: UIImage(CGImage: croppedImageCG))
//        presentViewController(imageVC, animated: true, completion: nil)
    }
    
    private func _getCroppedImageWithImage(image:CIImage, topLeft:CGPoint, topRight:CGPoint, botLeft:CGPoint, botRight:CGPoint) -> CIImage {
        var rectCoords:[String:AnyObject] = [:]
        rectCoords["inputTopLeft"] = CIVector(CGPoint:topLeft)
        rectCoords["inputTopRight"] = CIVector(CGPoint:topRight)
        rectCoords["inputBottomLeft"] = CIVector(CGPoint:botLeft)
        rectCoords["inputBottomRight"] = CIVector(CGPoint:botRight)
        return image.imageByApplyingFilter("CIPerspectiveCorrection", withInputParameters: rectCoords)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = UIImage(named: "test_image.jpg")!
        let image2 = UIImage(CGImage: testCrop())

        let imageView = UIImageView(image: image1)
        imageView.contentMode = .ScaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        let imageView2 = UIImageView(image: image2)
        imageView2.contentMode = .ScaleAspectFill
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView2)
        
        imageView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true

        imageView2.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        imageView2.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        imageView2.topAnchor.constraintEqualToAnchor(imageView.bottomAnchor).active = true
        imageView2.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
        imageView2.heightAnchor.constraintEqualToAnchor(imageView.heightAnchor).active = true
        
        imageView.clipsToBounds = true
        imageView2.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

