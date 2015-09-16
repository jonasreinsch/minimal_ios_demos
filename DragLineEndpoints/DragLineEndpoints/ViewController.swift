//
//  ViewController.swift
//  DragLineEndpoints
//
//  Created by Jonas Reinsch on 15.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "mainViewTapped:"))
        
        view.backgroundColor = UIColor.blackColor()
        
        let connectionView = ConnectionView()
        view.addSubview(connectionView)
        connectionView.addLayoutConstraints()
    }
    
    func mainViewTapped(gr:UITapGestureRecognizer) {
        let location = gr.locationInView(self.view)
        let d = Draggable()
        d.origin = CGPointMake(location.x-d.width/2.0,
                               location.y-d.height/2.0)
        view.addSubview(d)
        d.addDraggableConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

