//
//  SpeciesWrapper.swift
//  APIAwaken
//
//  Created by The Bao on 11/23/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

class SpeciesWrapper<T:JSONDecodable>:JSONDecodable {

    var species: [T]?
    var count: Int?
    var next: String?
    //fileprivate var previous: String?

    required init?(json: JSON) {
        guard let count = json["count"] as? Int,
            let next = json["next"] as? String
        else { return }
        guard let array = json["results"] as? [Any] else { return }
        var allResults = [T]()
        for result in array {
            guard let result = result as? JSON else { return }
                if let species = T(json: result){
                    allResults.append(species)
            }
        }
        self.species = allResults
        self.count = count
        self.next = next
        //self.previous = previous

    }
}
