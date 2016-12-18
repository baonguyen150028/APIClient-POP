//
//  AwakenClient.swift
//  APIAwaken
//
//  Created by The Bao on 11/22/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation



enum Category: EndPoint{
    case Character
    case StarShips
    case Vehicles

    var baseURL: URL {
        return URL(string: "http://swapi.co/api/")!
    }
    var path: String {
        switch self {
        case .Character:
            return "people/"
        case .StarShips:
            return "starships/"
        case .Vehicles:
            return "vehicles/"
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

    func fetchCharacter(pageURL: String? = nil, completion: @escaping (APIResult<Character>) -> Void){
        // Check next page
        let request: URLRequest
        if let pageURL = pageURL {
            let url = URL(string: pageURL)!
            request = URLRequest(url: url)
        } else {
            request = Category.Character.request
        }
        parseJSON(request: request, parse: {
            json -> SpeciesWrapper<Character>? in

            if let wrapper =  SpeciesWrapper<Character>(json: json){
                return wrapper
            } else {
                return nil
            }
        }, completion: completion)

    }
    
    func fetchHomeForCharacter(homeURL: String, comletion: @escaping (APIResult<Planet>) -> Void){
        guard let url = URL(string: homeURL) else { return }
        let request = URLRequest(url: url)
        parseJSON(request: request, parse: {
            json -> SpeciesWrapper<Planet>? in
            if let wrapper = SpeciesWrapper<Planet>(json: json){
                return wrapper
            } else {
                return nil
            }
        }, completion: comletion)
    }

    
}
