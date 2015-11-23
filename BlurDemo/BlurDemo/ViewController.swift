//
//  ViewController.swift
//  BlurDemo
//
//  Created by Jonas Reinsch on 22.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit


let imageFilename = "moscow_city.jpg"

class ViewController: UIViewController {
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        stackView.axis = .Vertical

        stackView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 20).active = true
        stackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        stackView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        stackView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        
        stackView.alignment = .Center
        stackView.distribution = .FillEqually
        for var i=0; i != 3; ++i {
            let innerStackView = UIStackView()
            innerStackView.distribution = .Fill
            innerStackView.alignment = .Center
            innerStackView.axis = .Vertical
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.text = "Test"
            label.backgroundColor = UIColor.greenColor()
        
            let imageView = UIImageView(image: UIImage(named: imageFilename))
            imageView.contentMode = .ScaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false

            imageView.setContentHuggingPriority(249, forAxis: .Vertical)
            imageView.setContentCompressionResistancePriority(749, forAxis: .Vertical)
            innerStackView.addArrangedSubview(imageView)
            innerStackView.addArrangedSubview(label)
            innerStackView.addArrangedSubview(slider)
            slider.leadingAnchor.constraintEqualToAnchor(innerStackView.leadingAnchor, constant: 20).active = true
            slider.trailingAnchor.constraintEqualToAnchor(innerStackView.trailingAnchor, constant: -20).active = true
            
            stackView.addArrangedSubview(innerStackView)
        }
        

        
        

        
        

        
    }
    
    override func viewDidLayoutSubviews() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

