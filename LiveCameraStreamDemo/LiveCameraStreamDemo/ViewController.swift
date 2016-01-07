//
//  ViewController.swift
//  LiveCameraStreamDemo
//
//  Created by Jonas Reinsch on 06.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the default camera (usually the back camera)
        // If you want the front camera instead
        // loop through AVCaptureDevice.devices() and use the
        // following check:
        // device.hasMediaType(AVMediaTypeVideo) &&
        // (device.position == AVCaptureDevicePosition.Front)
        
        // get the default capture device for video (back camera usually)
        guard let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) else {
            fatalError("capture device was nil")
        }
        
        // get input from the camera, configure the capture session
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            fatalError("can't access camera")
        }
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        captureSession.startRunning()
        
        // configure the preview layer
        guard let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) else {
            fatalError("preview layer was nil")
        }
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

