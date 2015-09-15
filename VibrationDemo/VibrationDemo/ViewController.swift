//
//  ViewController.swift
//  VibrationDemo
//
//  Created by Jonas Reinsch on 14.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        AudioServicesPlayAlertSound(UInt32(kSystemSoundID_Vibrate))
          AudioServicesPlaySystemSound(UInt32(kSystemSoundID_Vibrate))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

