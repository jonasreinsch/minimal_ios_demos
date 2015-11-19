//
//  MyCell.swift
//  AutomaticTableViewCellSizingDemo
//
//  Created by Jonas Reinsch on 19.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    let myLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // for dynamic type support, it is important that
    // the font is set each time cellForRowAtIndexPath gets called.
    // So we call this function from there. No explicit listening
    // to a change of the preferred font size is necessary, the system
    // will take care of the rest)
    func configure(s:String) {
        myLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        myLabel.text = s
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.numberOfLines = 0

        let leftConstraint = NSLayoutConstraint(item: myLabel, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 20)
        let topConstraint = NSLayoutConstraint(item: myLabel, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 20)
        let bottomConstraint = NSLayoutConstraint(item: myLabel, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: -20)
        let rightConstraint = NSLayoutConstraint(item: myLabel, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: -20)
        
        contentView.addConstraints([leftConstraint, topConstraint, bottomConstraint, rightConstraint])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
