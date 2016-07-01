//
//  CitiesTableController.swift
//  UISearchControllerDemoSimple
//
//  Created by Jonas Reinsch on 28.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit



class CitiesTableController: UITableViewController {
    // (1) gotcha: always use this constructor!
    // setting searchResultsController to nil means that we use
    // the same view for presenting the results that we use for searching
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredCities:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cities"
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
        
        // (2) needed in order to react to search text changes
        searchController.searchResultsUpdater = self
        // (3) in order for us to see something, we have to set the search bar
        tableView.tableHeaderView = searchController.searchBar
        
        // just for appearance
//        searchController.searchBar.searchBarStyle = .Minimal
        // set to false, because we present results in the same view
        searchController.dimsBackgroundDuringPresentation = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return filteredCities.count
        }
        return cities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        
        let row = indexPath.row
        guard let textLabel = cell.textLabel else {
            fatalError("cell.textLabel was nil, this should never happen")
        }
        
        if searchController.active {
            textLabel.text = filteredCities[row]
        } else {
            textLabel.text = cities[row]
        }

        return cell
    }
}


extension CitiesTableController:UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        
        if !searchString.isEmpty {
            filteredCities = cities.filter() {c in
                c.lowercaseString.hasPrefix(searchString.lowercaseString)
            }
        } else {
            filteredCities = cities
        }
        tableView.reloadData()
    }
}
