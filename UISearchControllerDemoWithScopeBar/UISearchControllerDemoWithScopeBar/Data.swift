//
//  Data.swift
//  UISearchControllerDemoWithScopeBar
//
//  Created by Jonas Reinsch on 29.01.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import Foundation

// we have cities from 3 continents

enum Continent {
    case Europe, Asia, America
}

struct City {
    let name:String
    let continent:Continent
}

let cities:[City] = [
    City(name:"Amsterdam", continent:.Europe),
    City(name:"Athens", continent:.Europe),
    City(name:"Bogota", continent:.Asia),
    City(name:"Bombay", continent:.Asia),
    City(name:"Buenos Aires", continent:.America),
    City(name:"Copenhagen", continent:.Europe),
    City(name:"Frankfurt", continent:.Europe),
    City(name:"Hong Hong", continent:.Asia),
    City(name:"Houston", continent:.America),
    City(name:"Jakarta", continent:.Asia),
    City(name:"Kuala Lumpur", continent:.Asia),
    City(name:"Lagos", continent:.Asia),
    City(name:"Los Angeles", continent:.America),
    City(name:"Mexico City", continent:.America),
    City(name:"Sao Paulo", continent:.America),
    City(name:"Singapore", continent:.Asia),
    City(name:"Vienna", continent:.Europe)]

