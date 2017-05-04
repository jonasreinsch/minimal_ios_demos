//
//  ViewController.swift
//  QRDemo
//
//  Created by Jonas Reinsch on 16.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

// code based on http://www.appcoda.com/qr-code-reader-swift/
// adapted for Swift 2.0
class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView = UIView()
    
    let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            
            captureSession.addInput(input as AVCaptureInput)
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
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
        messageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        messageLabel.textColor = UIColor.white
        messageLabel.backgroundColor = UIColor(white: 0.4, alpha: 0.5)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 27)
        
        messageLabel.text = "-"
        
        qrCodeFrameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(qrCodeFrameView)
        
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 4
        view.addSubview(qrCodeFrameView)
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        guard let metadataObjects = metadataObjects else {
            messageLabel.text = "-"
            qrCodeFrameView.frame = CGRect.zero
            return
        }
        if metadataObjects.count == 0 {
            messageLabel.text = "-"
            qrCodeFrameView.frame = CGRect.zero
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                if (messageLabel.text! != metadataObj.stringValue) {
                    AudioServicesPlaySystemSound(UInt32(kSystemSoundID_Vibrate))
                    messageLabel.text = metadataObj.stringValue
                }
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

