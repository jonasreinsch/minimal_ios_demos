//
//  ViewController.swift
//  FirstScene
//
//  Created by Jonas Reinsch on 09.10.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//
//  This is a Swift port of the example in David Rönnqvists Book
//  3D Graphics with Scene Kit

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    let scene = SCNScene()
    let sceneView = SCNView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // The scene
        sceneView.scene = scene
        
        // A square box with sharp counters
        let boxSide:CGFloat = 10
        let box = SCNBox(width: boxSide, height: boxSide, length: boxSide, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        // rotate the box a bit
        boxNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/5))
        scene.rootNode.addChildNode(boxNode)
        
        // Camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 10, 20)
        // -atan(camY/camX)
        cameraNode.rotation = SCNVector4Make(1, 0, 0, -atan2f(10, 20))
        scene.rootNode.addChildNode(cameraNode)
        
        // Light
        let lightBlueColor = UIColor(red: 4/255, green: 120/255, blue: 255/255, alpha: 1).CGColor
        let light = SCNLight()
        light.type = SCNLightTypeDirectional
        light.color = lightBlueColor
        
        let lightNode = SCNNode()
        lightNode.light = light
        cameraNode.addChildNode(lightNode)
        
        sceneView.frame = UIScreen.mainScreen().bounds
        view.addSubview(sceneView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

