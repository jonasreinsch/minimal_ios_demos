//
//  ViewController.swift
//  PDFDemo
//
//  Created by Jonas Reinsch on 08.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReaderViewControllerDelegate {
    
    var readerViewController:ReaderViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("Reader", ofType: "pdf")
        
        if let path = path {
            let readerDocument = ReaderDocument(filePath: path, password: nil)
            readerViewController = ReaderViewController(readerDocument: readerDocument)
            
            readerViewController.delegate = self
            
            readerViewController.modalTransitionStyle = .CrossDissolve
            readerViewController.modalPresentationStyle = .FullScreen
            
            let tgr = UITapGestureRecognizer(target: self, action: "showReaderViewController")
            view.addGestureRecognizer(tgr)
        }
    }
    
    func dismissReaderViewController(viewController: ReaderViewController!) {
        readerViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showReaderViewController() {
        presentViewController(readerViewController, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

