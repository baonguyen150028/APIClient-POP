//
//  Characters.swift
//  APIAwaken
//
//  Created by The Bao on 11/22/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

class Character: JSONDecodable {
    var name: String = ""
    var born: String = ""
    var home: String = ""
    var height: String = ""
    var eye: String = ""
    var hair: String = ""

    required init?(json: JSON) {
        guard   let name = json["name"] as? String,
                let born = json["birth_year"] as? String,
                let height = json["height"] as? String,
                let eye = json["eye_color"] as? String,
                let hair = json["hair_color"] as? String else {
                return nil
        }
        self.name = name
        self.born = born
        self.height = height
        self.eye = eye
        self.hair = hair
    }

}
//MARK: Get Home 
extension Character {
    func getHome() {

    }
}


