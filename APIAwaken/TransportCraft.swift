//
//  TransportCraft.swift
//  APIAwaken
//
//  Created by The Bao on 11/22/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
class TransportCraft {
    var name: String
    var make: String
    var cost: Int
    var length: Int
    var classShips: String
    var crew: Int
    init(name: String, make: String, cost: Int, length: Int, classShips: String, crew: Int) {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.classShips = classShips
        self.crew = crew
    }
}

class Starships: TransportCraft {
    override init(name: String, make: String, cost: Int, length: Int, classShips: String, crew: Int) {
        super.init(name: name, make: make, cost: cost, length: length, classShips: classShips, crew: crew)
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.classShips = classShips
        self.crew = crew
    }
}
class Vehicles: TransportCraft {
    override init(name: String, make: String, cost: Int, length: Int, classShips: String, crew: Int) {
        super.init(name: name, make: make, cost: cost, length: length, classShips: classShips, crew: crew)
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.classShips = classShips
        self.crew = crew
    }
    
}
