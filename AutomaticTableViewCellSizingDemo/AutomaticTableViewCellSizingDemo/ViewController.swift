//
//  ViewController.swift
//  AutomaticTableViewCellSizingDemo
//
//  Created by Jonas Reinsch on 19.11.15.
//  Copyright © 2015 Jonas Reinsch. All rights reserved.
//

import UIKit

let MY_CELL = "__my_cell_identifier__"

let texts = [
    "Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, 'and what is the use of a book,' thought Alice 'without pictures or conversations?'",
    "Alice took up the fan",
    "'I'm sure I'm not Ada,' she said, 'for her hair goes in such long ringlets, and mine doesn't go in ringlets at all; and I'm sure I can't be Mabel, for I know all sorts of things, and she, oh! she knows such a very little! Besides, SHE'S she, and I'm I, and--oh dear, how puzzling it all is! I'll try if I know all the things I used to know. Let me see: four times five is twelve, and four times six is thirteen, and four times seven is--oh dear! I shall never get to twenty at that rate! However, the Multiplication Table doesn't signify: let's try Geography.",
    "'How cheerfully he seems to grin,",
    "'How CAN I have done that?'",
    "They were indeed a queer-looking party that assembled on the bank--the birds with draggled feathers, the animals with their fur clinging close to them, and all dripping wet, cross, and uncomfortable."
]

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.registerClass(MyCell.self, forCellReuseIdentifier: MY_CELL)
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MY_CELL) as! MyCell
        
        cell.configure(texts[indexPath.row])
        
        return cell
    }
}

