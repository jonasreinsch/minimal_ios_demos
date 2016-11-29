//
//  SelectionController.swift
//  MapDemo
//
//  Created by Jonas Reinsch on 18.07.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

let pois:[(String, (Double, Double))] = [
(
"Kirche St. Blasius Zähringen",
(48.0234951, 7.8651831)
//(47.9956, 7.8528)
),

(
"Augustiner Museum",
(47.9941106, 7.8524429)
),

(
"Heliotrop",
(47.9732657, 7.8332675)
),

(
"Freiburger Münster",
(47.9954313, 7.8533915)
),

(
"Max Planck Institut für Immunobiologie und Epigenetik",
(48.0253542, 7.8517698)
)
]

class SelectionController: UITableViewController {
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pois.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        
        let poi = pois[row]
        let title = poi.0
        
        cell.textLabel?.text = title

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        let poi = pois[row]
        let title = poi.0
        let location = poi.1
        let c = ViewController(title:title, location: location)
        navigationController?.pushViewController(c, animated: true)
    }
}
