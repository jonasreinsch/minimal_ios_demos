//
//  CitiesTableController.swift
//  UISearchControllerDemoWithScopeBar
//
//  Created by Jonas Reinsch on 29.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

func searchControllerActiveAndNotEmpty(searchController:UISearchController) -> Bool {
    guard let text = searchController.searchBar.text else {
        return false
    }

    return searchController.active && !text.isEmpty
}

class CitiesTableController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCities:[City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Cities"
        
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .Minimal
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
        if searchControllerActiveAndNotEmpty(searchController) {
            return filteredCities.count
        } else {
            return cities.count
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: String(UITableViewCell))
        }
        
        guard let defCell = cell else {
            fatalError("cell was nil at a point where it shouldn't be")
        }
        
        let row = indexPath.row
        
        let city:City
        if searchControllerActiveAndNotEmpty(searchController) {
            city = filteredCities[row]
        } else {
            city = cities[row]
        }
        defCell.textLabel?.text = city.name
        defCell.detailTextLabel?.text = String(city.continent)
        
        return defCell
    }
}

extension CitiesTableController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        filteredCities = cities.filter {
            city in
            city.name.lowercaseString.hasPrefix(text.lowercaseString)
        }
        tableView.reloadData()
    }
}
