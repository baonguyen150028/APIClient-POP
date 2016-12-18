//
//  File.swift
//  APIAwaken
//
//  Created by The Bao on 11/25/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

class CharacterManager {

    let awakenClient = AwakenClient()
    var species = [Character]()

    func fetchCharacter(pageURL: String?){
        var nextPage: String? = nil
        if let url = pageURL {
            nextPage = url
        }
        
        awakenClient.fetchCharacter(pageURL: nextPage, completion: {
            [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .Success(let wrapper):
                guard let nextPage = wrapper.next else { return }
                strongSelf.species = strongSelf.species + wrapper.species!
                strongSelf.fetchCharacter(pageURL: nextPage)
            case .Failure(let error):
                print(error)
            }
        })
    }
    func fetchHomeCharacter(homeURL: String?){
        guard let homeURL = homeURL else { return }
        awakenClient.fetchHomeForCharacter(homeURL: homeURL, comletion: {
            result in
            switch result {
            case .Success(let wrapper):
                break
            case .Failure(let error):
                print(error)
            }
        })
    }

}
