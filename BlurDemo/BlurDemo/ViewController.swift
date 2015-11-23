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
    let labels = [UILabel(), UILabel(), UILabel()]
    let sliders = [UISlider(), UISlider(), UISlider()]
    let effectViews = [UIVisualEffectView(effect: nil),
                       UIVisualEffectView(effect: nil),
                       UIVisualEffectView(effect: nil)]
    let effectStyles = [(constant:UIBlurEffectStyle.ExtraLight, name:"Extra Light"),
        (constant:UIBlurEffectStyle.Light, name:"Light"),
        (constant:UIBlurEffectStyle.Dark, name:"Dark")]
    
    func makeLabelText(idx:Int, value:Float) -> String {
        let valueInPercent = Int(round(value * 100))
        return("Blur Effect Style: \(effectStyles[idx].name) (\(valueInPercent)% blurred)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        stackView.axis = .Vertical

        stackView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 20).active = true
        stackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        stackView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        stackView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        
        stackView.alignment = .Fill
        stackView.distribution = .FillEqually
        
        for var i=0; i != 3; ++i {
            let innerStackView = UIStackView()
            innerStackView.distribution = .Fill
            innerStackView.alignment = .Center
            innerStackView.axis = .Vertical
        
            let imageView = UIImageView(image: UIImage(named: imageFilename))
            imageView.backgroundColor = UIColor.blackColor()
            imageView.contentMode = .ScaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let effect = UIBlurEffect(style: effectStyles[i].constant)

            let effectView = effectViews[i]
            UIView.animateWithDuration(1) {
                effectView.effect = effect
            }
            effectView.layer.speed = 0
            
            effectView.translatesAutoresizingMaskIntoConstraints = false
            imageView.addSubview(effectView)

            effectView.leadingAnchor.constraintEqualToAnchor(imageView.leadingAnchor).active = true
            effectView.trailingAnchor.constraintEqualToAnchor(imageView.trailingAnchor).active = true
            effectView.topAnchor.constraintEqualToAnchor(imageView.topAnchor).active = true
            effectView.bottomAnchor.constraintEqualToAnchor(imageView.bottomAnchor).active = true

            labels[i].translatesAutoresizingMaskIntoConstraints = false

            sliders[i].translatesAutoresizingMaskIntoConstraints = false
            sliders[i].tag = i
            
            labels[i].text = makeLabelText(i, value: 0)

            imageView.setContentHuggingPriority(249, forAxis: .Vertical)
            imageView.setContentCompressionResistancePriority(749, forAxis: .Vertical)
            innerStackView.addArrangedSubview(imageView)
            innerStackView.addArrangedSubview(labels[i])
            innerStackView.addArrangedSubview(sliders[i])
            sliders[i].leadingAnchor.constraintEqualToAnchor(innerStackView.leadingAnchor, constant: 20).active = true
            sliders[i].trailingAnchor.constraintEqualToAnchor(innerStackView.trailingAnchor, constant: -20).active = true
            sliders[i].addTarget(self, action: "sliderDragged:", forControlEvents: .ValueChanged)
            
            stackView.addArrangedSubview(innerStackView)
        }
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    func sliderDragged(slider:UISlider) {
        labels[slider.tag].text = makeLabelText(slider.tag, value:slider.value)
        effectViews[slider.tag].layer.timeOffset = Double(slider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

