//
//  AwakenClient.swift
//  APIAwaken
//
//  Created by The Bao on 11/22/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

enum Category: EndPoint{
    case Character (page: Int)
    case StarShips (page: Int)
    case Vehicles (page: Int)

    var baseURL: URL {
        return URL(string: "http://swapi.co/api/")!
    }
    var path: String {
        switch self {
        case .Character(let page):
            return "people/\(page))/"
        case .StarShips(let page):
            return "starships/\(page)/"
        case .Vehicles(let page):
            return "verhicles/\(page)/"
        }
    }
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        return URLRequest(url: url)
    }


}

final class AwakenClient: APIClient {
    let configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()

    init(config: URLSessionConfiguration) {
        self.configuration = config
    }

    convenience init() {
        self.init(config: URLSessionConfiguration.default)
    }

    func fetchCharacter(completion: @escaping (APIResult<Character>) -> Void){
        let request = Category.Character(page: 1).request
        parseJSON(request: request, parse: {
            json -> [Character]? in
            guard let array = json["results"] as? [Any] else { return []}
            var characters = [Character]()

            for resultDict in array {
                if let characterDict = resultDict as? [String: Any] {
                    if let character = Character(json: characterDict){
                        characters.append(character)
                    }
                }
            }
            return characters
        }, completion: completion)
    }
}
