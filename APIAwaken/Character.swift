//
//  Characters.swift
//  APIAwaken
//
//  Created by The Bao on 11/22/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

struct Character: JSONDecodable {
    var name: String?
    var born: String?
    var home: Planet?
    var height: String?
    var eye: String?
    var hair: String?
    var homeURL: String?

    init?(json: JSON) {
        guard   let name = json["name"] as? String,
                let born = json["birth_year"] as? String,
                let height = json["height"] as? String,
                let eye = json["eye_color"] as? String,
                let hair = json["hair_color"] as? String,
                let homeURL = json["homeworld"] as? String else {
                return nil
        }
        self.name = name
        self.born = born
        self.height = height
        self.eye = eye
        self.hair = hair
        self.homeURL = homeURL
    }

}


