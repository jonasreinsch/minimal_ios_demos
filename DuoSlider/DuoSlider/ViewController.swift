//
//  ViewController.swift
//  DuoSlider
//
//  Created by Jonas Reinsch on 30/11/2016.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let duoSlider = DuoSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        view.addSubview(duoSlider.containerView)
        duoSlider.containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        duoSlider.containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        duoSlider.containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        duoSlider.d1.setPosition(0)
        duoSlider.d2.setPosition(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

