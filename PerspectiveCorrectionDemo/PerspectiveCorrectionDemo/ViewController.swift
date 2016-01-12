//
//  ViewController.swift
//  PerspectiveCorrectionDemo
//
//  Created by Jonas Reinsch on 11.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, DragViewDelegate {
    func testCrop(ptBotLeft:CGPoint, ptBotRight:CGPoint, ptTopRight:CGPoint, ptTopLeft:CGPoint) -> CGImage {
        
        let ciInputImage = CIImage(image:UIImage(named:"example_bc")!)
        
        print("source image is \(ciInputImage)")
        
        let croppedImage = _getCroppedImageWithImage(ciInputImage!, topLeft: ptTopLeft, topRight: ptTopRight, botLeft: ptBotLeft, botRight: ptBotRight)
        print("cropped image \(croppedImage)")
        
        let croppedImageCG = CIContext(options: nil).createCGImage(croppedImage, fromRect: croppedImage.extent)
        
        return croppedImageCG

    }
    
    private func _getCroppedImageWithImage(image:CIImage, topLeft:CGPoint, topRight:CGPoint, botLeft:CGPoint, botRight:CGPoint) -> CIImage {
        var rectCoords:[String:AnyObject] = [:]
        rectCoords["inputTopLeft"] = CIVector(CGPoint:topLeft)
        rectCoords["inputTopRight"] = CIVector(CGPoint:topRight)
        rectCoords["inputBottomLeft"] = CIVector(CGPoint:botLeft)
        rectCoords["inputBottomRight"] = CIVector(CGPoint:botRight)
        return image.imageByApplyingFilter("CIPerspectiveCorrection", withInputParameters: rectCoords)
    }

    var imageView:UIImageView!
    var imageView2:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = UIImage(named: "example_bc")!


        imageView = UIImageView(image: image1)
        imageView.contentMode = .ScaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView2 = UIImageView()
        imageView2.contentMode = .ScaleAspectFit
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

        makeDragViews()
    }
    
    let dragView1 = DragView()
    let dragView2 = DragView()
    let dragView3 = DragView()
    let dragView4 = DragView()
    
    func makeDragViews() {
        dragView1.delegate = self
        dragView2.delegate = self
        dragView3.delegate = self
        dragView4.delegate = self
        
        imageView.addSubview(dragView1)
        imageView.addSubview(dragView2)
        imageView.addSubview(dragView3)
        imageView.addSubview(dragView4)
        imageView.userInteractionEnabled = true
        
        dragView1.setPosition(CGPointMake(70, 50))
        dragView2.setPosition(CGPointMake(150, 50))
        dragView3.setPosition(CGPointMake(70, 200))
        dragView4.setPosition(CGPointMake(140, 190))
        
    }
    
    func flipY(p:CGPoint) -> CGPoint {
        let rectInside = AVMakeRectWithAspectRatioInsideRect(imageView.image!.size, imageView.bounds)
        
        let scale = imageView.image!.size.width /
            AVMakeRectWithAspectRatioInsideRect(imageView.image!.size, imageView.bounds).width
        
        return CGPointMake(scale * (p.x - rectInside.origin.x), scale * (rectInside.height - (p.y - rectInside.origin.y)))
    }
    
    func didDragTo(p: CGPoint) {
        print(p.x, imageView.bounds.height - p.y)
        let ptBotLeft = flipY(dragView1.position())
        let ptBotRight = flipY(dragView2.position())
        let ptTopRight = flipY(dragView3.position())
        let ptTopLeft = flipY(dragView4.position())
        
        let img = testCrop(ptBotLeft, ptBotRight: ptBotRight, ptTopRight: ptTopRight, ptTopLeft: ptTopLeft)
        imageView2.image = UIImage(CGImage: img)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

