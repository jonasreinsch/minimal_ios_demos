//
//  ViewController.swift
//  DragLineEndpoints
//
//  Created by Jonas Reinsch on 15.09.15.
//  Copyright (c) 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var draggables:[Draggable] = []
    let connectionView = ConnectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "mainViewTapped:"))
        
        view.addSubview(connectionView)
        connectionView.addLayoutConstraints()
        connectionView.backgroundColor = UIColor.blackColor()
    }
    
    func mainViewTapped(gr:UITapGestureRecognizer) {
        let location = gr.locationInView(self.view)
        makeDraggableAtPoint(location)
    }
    
    func makeDraggableAtPoint(p:CGPoint) {
        let d = Draggable()
        d.connectionView = connectionView
        d.viewController = self
        d.position = CGPointMake(p.x-d.width/2.0,
                                 p.y-d.height/2.0)
        view.addSubview(d)
        d.addDraggableConstraints()
        
        draggables.append(d)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

