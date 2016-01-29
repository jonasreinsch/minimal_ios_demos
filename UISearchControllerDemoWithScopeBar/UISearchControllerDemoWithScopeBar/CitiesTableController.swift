//
//  CitiesTableController.swift
//  UISearchControllerDemoWithScopeBar
//
//  Created by Jonas Reinsch on 29.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit

func filterCitiesBySearchString(cities:[City], searchString:String) -> [City] {
    assert(!searchString.isEmpty)
    
    return cities.filter() {c in
        c.name.lowercaseString.hasPrefix(searchString.lowercaseString)
    }
}

func filterCitiesByContintent(cities:[City], continent:Continent) -> [City] {
    return cities.filter() {c in
        c.continent == continent
    }
}

class CitiesTableController: UITableViewController {
    // setting searchResultsController to nil has the effect of
    // using the same view for search results
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCities:[City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Cities"
        
        // needed to make the search bar appear
        tableView.tableHeaderView = searchController.searchBar
        // needed to be able to react to text changes in the search bar
        searchController.searchResultsUpdater = self
        // needed to make the scope button appear
        searchController.searchBar.scopeButtonTitles = ["All"] + Continent.allValues.map {String($0)}
        // needed in order to react to changes of the scope button index
        searchController.searchBar.delegate = self
        
        // just for appearance (do not dim the view, because we
        // present search results in the same view)
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
        if searchController.active {
            city = filteredCities[row]
        } else {
            city = cities[row]
        }
        defCell.textLabel?.text = city.name
        defCell.detailTextLabel?.text = String(city.continent)
        
        return defCell
    }
    
    func filterCitiesAndReloadData() {
        // step 1: determine the search string - we treat nil as empty string
        let searchString = searchController.searchBar.text ?? ""
        
        // step 2: filter the cities by the search string
        //         if search string is empty, we keep all cities
        let filteredCitiesBySearchString:[City]
        if !searchString.isEmpty {
            filteredCitiesBySearchString = filterCitiesBySearchString(cities, searchString: searchString)
        } else {
            filteredCitiesBySearchString = cities
        }
        
        // step 3: filter the cities further by continent
        //         if no continent is selected, we do no further filtering
        let scopeIndex = searchController.searchBar.selectedScopeButtonIndex
        if scopeIndex != 0 {
            let selectedContinent = Continent.allValues[scopeIndex - 1]
            filteredCities = filterCitiesByContintent(filteredCitiesBySearchString, continent: selectedContinent)
        } else {
            filteredCities = filteredCitiesBySearchString
        }
        tableView.reloadData()
    }
}

extension CitiesTableController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterCitiesAndReloadData()
    }
}

extension CitiesTableController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterCitiesAndReloadData()
    }
}
