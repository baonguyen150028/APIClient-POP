//
//  Planet.swift
//  APIAwaken
//
//  Created by The Bao on 11/25/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

struct Planet: JSONDecodable {
    var name: String = ""

    init?(json: JSON) {
        guard let name = json["name"] as? String else { return }
        self.name = name
    }


}
