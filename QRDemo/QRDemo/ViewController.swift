//
//  ViewController.swift
//  QRDemo
//
//  Created by Jonas Reinsch on 16.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView = UIView()
    
    let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            
            captureSession.addInput(input as AVCaptureInput)
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            videoPreviewLayer?.frame = view.layer.bounds
            
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession.startRunning()
        } catch {
            print("\(error)")
        }
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        let bottomConstraint = NSLayoutConstraint(item: messageLabel, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: messageLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomConstraint)
        view.addConstraint(centerXConstraint)
        
        messageLabel.textColor = UIColor.whiteColor()
        messageLabel.backgroundColor = UIColor(white: 0.4, alpha: 0.5)
        messageLabel.numberOfLines = 0
        
        messageLabel.text = "--nothing detected yet--"

        qrCodeFrameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(qrCodeFrameView)
        
        qrCodeFrameView.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView.layer.borderWidth = 4
        view.addSubview(qrCodeFrameView)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        guard let metadataObjects = metadataObjects else {
            messageLabel.text = "No QR code is detected"
            qrCodeFrameView.frame = CGRectZero
            return
        }
        if metadataObjects.count == 0 {
            messageLabel.text = "No QR code is detected"
            qrCodeFrameView.frame = CGRectZero
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                messageLabel.text = metadataObj.stringValue
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = view.layer.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

