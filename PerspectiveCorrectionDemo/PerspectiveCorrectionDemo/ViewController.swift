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

func logicalCoordinatesToImageCoordinates(logicalPoint:CGPoint, image:UIImage) -> CGPoint {
    assert(0 < image.size.width)
    assert(0 < image.size.height)
    assert(0 <= logicalPoint.x)
    assert(logicalPoint.x <= 1)
    assert(0 <= logicalPoint.y)
    assert(logicalPoint.y <= 1)
    
    return CGPointMake(image.size.width * logicalPoint.x, image.size.height * logicalPoint.y)
}

func logicalCoordinatesToImageViewCoordinates(logicalPoint:CGPoint, imageView:UIImageView) -> CGPoint {
    guard let image = imageView.image else {
        fatalError("image was nil in logicalCoordinatesToImageViewCoordinates")
    }
    
    assert(0 <= logicalPoint.x)
    assert(logicalPoint.x <= 1)
    assert(0 <= logicalPoint.y)
    assert(logicalPoint.y <= 1)
    assert(imageView.bounds.width > 0, "width of imageView expected to be greater than 0")
    assert(imageView.bounds.height > 0, "height of imageView expected to be greater than 0")
    
    let r = AVMakeRectWithAspectRatioInsideRect(image.size, imageView.bounds)
    
    return CGPointMake(r.origin.x + logicalPoint.x * r.size.width,
        r.origin.y + logicalPoint.y * r.size.height)
}

func imageViewCoordinatesToLogicalCoordinates(imageViewPoint:CGPoint, imageView:UIImageView) -> CGPoint {
    
    guard let image = imageView.image else {
        fatalError("image was nil in logicalCoordinatesToImageViewCoordinates")
    }
    
    assert(imageView.bounds.width > 0, "width of imageView expected to be greater than 0")
    assert(imageView.bounds.height > 0, "height of imageView expected to be greater than 0")
    assert(0 <= imageViewPoint.x)
    assert(imageViewPoint.x <= imageView.bounds.width)
    assert(0 <= imageViewPoint.y)
    assert(imageViewPoint.y <= imageView.bounds.height)
    
    let r = AVMakeRectWithAspectRatioInsideRect(image.size, imageView.bounds)
    
    let imageViewPointWithoutOffset = CGPointMake(imageViewPoint.x - r.origin.x,
        imageViewPoint.y - r.origin.y)
    return CGPointMake(imageViewPointWithoutOffset.x / r.width,
        imageViewPointWithoutOffset.y / r.height)
}


func imageCoordinatesToLogicalCoordinates(imagePoint:CGPoint, image:UIImage) -> CGPoint {
    assert(0 < image.size.width)
    assert(0 < image.size.height)
    assert(0 <= imagePoint.x)
    assert(imagePoint.x <= image.size.width)
    assert(0 <= imagePoint.y)
    assert(imagePoint.y <= image.size.height)
    
    return CGPointMake(image.size.width/imagePoint.x, image.size.height/imagePoint.y)
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
        
        stackView.addArrangedSubview(imageView2)
        stackView.addArrangedSubview(imageView)

        imageView.clipsToBounds = true
        imageView2.clipsToBounds = true


    }
    
    override func viewDidAppear(animated: Bool) {


        
        
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
        
        
        let r = AVMakeRectWithAspectRatioInsideRect(imageView.image!.size, imageView.bounds)
        // check if image is portrait or landscape
        let imageWidth = r.width // imageView.image!.size.width
        let imageHeight = r.height // imageView.image!.size.height
        let insetX:CGFloat
        let insetY:CGFloat
        if imageWidth > imageHeight {
            // landscape
            let frameRectWidth = 0.7 * imageWidth
            let frameRectHeight = imageWidth / 1.545454
            insetX = (imageWidth - frameRectWidth) / 2
            insetY = (imageHeight - frameRectHeight) / 2
        } else {
            // portrait
            let frameRectHeight = 0.7 * imageHeight
            let frameRectWidth = frameRectHeight / 1.545454
            insetX = (imageWidth - frameRectWidth) / 2
            insetY = (imageHeight - frameRectHeight) / 2
        }
        print(insetX)
        print(insetY)

        let ri = CGRectInset(r, insetX, insetY)
        let p1 = CGPointMake(CGRectGetMinX(ri), CGRectGetMinY(ri))
        let p2 = CGPointMake(CGRectGetMinX(ri), CGRectGetMaxY(ri))
        let p3 = CGPointMake(CGRectGetMaxX(ri), CGRectGetMaxY(ri))
        let p4 = CGPointMake(CGRectGetMaxX(ri), CGRectGetMinY(ri))

        
        dragView1.setPosition(p1)
        dragView2.setPosition(p2)
        dragView3.setPosition(p3)
        dragView4.setPosition(p4)
        
        didDragTo(CGPointZero)
    }
    
    func flipY(p:CGPoint) -> CGPoint {
        let rectInside = AVMakeRectWithAspectRatioInsideRect(imageView.image!.size, imageView.bounds)
        
        let scale = imageView.image!.size.width /
            AVMakeRectWithAspectRatioInsideRect(imageView.image!.size, imageView.bounds).width
        
        return CGPointMake(scale * (p.x - rectInside.origin.x), scale * (rectInside.height - (p.y - rectInside.origin.y)))
    }
    
    
    
    
    
    
    var calculating = false
    func didDragTo(_: CGPoint) {
        if calculating {
            return
        }
        calculating = true
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
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let img = self.testCrop(ptBotLeft, ptBotRight: ptBotRight, ptTopRight: ptTopRight, ptTopLeft: ptTopLeft)
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView2.image = UIImage(CGImage: img)
                self.calculating = false
            }
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ _ -> Void in
            
            
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                guard let imageView = self.imageView else {
                    print("imageView was nil, returning")
                    return
                }
                if self.dragView1.superview == nil {
                    print("superview of drag view still nil, returning")
                    return
                }
                
                print("imageView bounds", imageView.bounds)
                
                let p1 = logicalCoordinatesToImageViewCoordinates(self.dragView1.logicalPosition, imageView: imageView)
                self.dragView1.centerXConstraint.constant = p1.x
                self.dragView1.centerYConstraint.constant = p1.y
                print(self.dragView1.logicalPosition)
                print(p1)
                

                let p2 = logicalCoordinatesToImageViewCoordinates(self.dragView2.logicalPosition, imageView: imageView)
                self.dragView2.centerXConstraint.constant = p2.x
                self.dragView2.centerYConstraint.constant = p2.y
                let p3 = logicalCoordinatesToImageViewCoordinates(self.dragView3.logicalPosition, imageView: imageView)
                self.dragView3.centerXConstraint.constant = p3.x
                self.dragView3.centerYConstraint.constant = p3.y

                let p4 = logicalCoordinatesToImageViewCoordinates(self.dragView4.logicalPosition, imageView: imageView)
                self.dragView4.centerXConstraint.constant = p4.x
                self.dragView4.centerYConstraint.constant = p4.y

        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

