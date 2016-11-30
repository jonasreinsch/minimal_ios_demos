//
//  ViewController.swift
//  DuoSlider
//
//  Created by Jonas Reinsch on 30/11/2016.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let d1 = Draggable()
    let d2 = Draggable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(d1)
        view.addSubview(d2)
        d1.addDraggableConstraints()
        d2.addDraggableConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

