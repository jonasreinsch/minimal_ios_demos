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
        
        view.backgroundColor = UIColor.blackColor()
        

        view.addSubview(connectionView)
        connectionView.addLayoutConstraints()
        
        makeDraggableAtPoint(CGPointMake(30, 40))
        makeDraggableAtPoint(CGPointMake(300, 400))
        connectionView.connections = [(draggables[0], draggables[1])]
        
        connectionView.backgroundColor = UIColor.blackColor()
    }
    
    func mainViewTapped(gr:UITapGestureRecognizer) {
        let location = gr.locationInView(self.view)
        makeDraggableAtPoint(location)
    }
    
    func makeDraggableAtPoint(p:CGPoint) {
        let d = Draggable()
        d.connectionView = connectionView
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

