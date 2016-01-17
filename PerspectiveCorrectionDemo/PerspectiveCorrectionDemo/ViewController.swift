//
//  ViewController.swift
//  PerspectiveCorrectionDemo
//
//  Created by Jonas Reinsch on 11.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit
import AVFoundation

let image = UIImage(named:"test_image.jpg")!

// for EXIF orientation, see:
// https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CGImageProperties_Reference/index.html#//apple_ref/c/data/kCGImagePropertyOrientation
// for UIImageOrientation, see:
// https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIImage_Class/#//apple_ref/c/tdef/UIImageOrientation
func UIImageOrientationToExifOrientation(imageOrientation:UIImageOrientation) -> Int32 {
    switch imageOrientation {
    case .Up: return 1
    case .Down: return 3
    case .Left: return 8
    case .Right: return 6
    case .UpMirrored: return 2
    case .DownMirrored: return 4
    case .LeftMirrored: return 5
    case .RightMirrored: return 7
    }
}

class ViewController: UIViewController, DragViewDelegate {
    func testCrop(ptBotLeft:CGPoint, ptBotRight:CGPoint, ptTopRight:CGPoint, ptTopLeft:CGPoint) -> CGImage {

        let img = CIImage(image: image)
        let exifOrientation = UIImageOrientationToExifOrientation(image.imageOrientation)
        
        // the CIImage does not use the orientation automatically,
        // therefore we have to provide it (it needs the EXIF
        // orientation convention, therefore we need to
        // convert from UIImageOrientation to EXIF orientation)
        let ciInputImage = img!.imageByApplyingOrientation(exifOrientation)
        
        
        let croppedImage = _getCroppedImageWithImage(ciInputImage, topLeft: ptTopLeft, topRight: ptTopRight, botLeft: ptBotLeft, botRight: ptBotRight)
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
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
        stackView.alignment = .Center
        stackView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        stackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        stackView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        stackView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        
        imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        
        imageView2 = UIImageView()
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        imageView2.backgroundColor = UIColor.blackColor()
        imageView2.contentMode = .ScaleAspectFit
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(imageView2)

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

        // add validation, like suggested here:
        // http://gamedev.stackexchange.com/questions/104262/getting-the-topleft-topright-bottomleft-and-bottomright-points-of-a-shape-in-u
        
        /*
        There are many corner cases:
        
        shapes like a <> diamond,
        shapes where the lines cross (if lines are predetermined);
        shapes where points coincide.
        
        A validation would probably be something like this:
        
        reject shape if line segments overlap;
        reject shape if points are too close or lines are too short;
        reject shape if angles seem too strange.
        */

        var topLeft:CGPoint
        var topRight:CGPoint
        var bottomLeft:CGPoint
        var bottomRight:CGPoint
        
        var points = [dragView1.position(), dragView2.position(), dragView3.position(), dragView4.position()]
        
        points.sortInPlace {p1, p2 in p1.y < p2.y} // sort from top to bottom
        
        print(points)
        if points[0].x < points[1].x {
            topLeft = points[0]
            topRight = points[1]
        } else {
            topRight = points[0]
            topLeft = points[1]
        }
        if points[2].x < points[3].x {
            bottomLeft = points[2]
            bottomRight = points[3]
        } else {
            bottomRight = points[2]
            bottomLeft = points[3]
        }
        
        let ptBotLeft = flipY(bottomLeft)
        let ptBotRight = flipY(bottomRight)
        let ptTopRight = flipY(topRight)
        let ptTopLeft = flipY(topLeft)
        
        let img = testCrop(ptBotLeft, ptBotRight: ptBotRight, ptTopRight: ptTopRight, ptTopLeft: ptTopLeft)
        imageView2.image = UIImage(CGImage: img)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

