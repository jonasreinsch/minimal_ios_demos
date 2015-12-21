//
//  ViewController.swift
//  AutoGrowingTextFieldDemo
//
//  Created by Jonas Reinsch on 02.12.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

let backgroundColor = UIColor.darkGrayColor()
let textFieldBackgroundColor = UIColor.blackColor()
let cursorTintColor = UIColor.whiteColor()
let textColor = UIColor.whiteColor()

class MyTextField: UITextField {
    // see http://stackoverflow.com/a/28006804 for documentation
    // of auto-growing text field
    override func intrinsicContentSize() -> CGSize {
        let size = editing ? (super.text! as NSString).sizeWithAttributes(self.typingAttributes) : super.intrinsicContentSize()
        if size.width > 30 {
            return CGSizeMake(size.width, size.height)
        } else {
            return CGSizeMake(30, size.height)
        }
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        let textField = MyTextField()
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.leadingAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        textField.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        textField.backgroundColor = textFieldBackgroundColor
        textField.textColor = textColor
        // make the cursor white
        textField.tintColor = cursorTintColor
        
        textField.font = UIFont.systemFontOfSize(25)
        
        textField.addTarget(self, action: "editingChanged:", forControlEvents: .EditingChanged)
        
        textField.autocorrectionType = .No
        textField.becomeFirstResponder()
    }
    
    func editingChanged(textField:MyTextField) {
        textField.invalidateIntrinsicContentSize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

