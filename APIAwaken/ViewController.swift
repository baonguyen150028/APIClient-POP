//
//  ViewController.swift
//  APIAwaken
//
//  Created by The Bao on 11/22/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let awakenClient = AwakenClient()
    var species = [Character]()

    var characterWrapper: SpeciesWrapper<Character>?

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
                    strongSelf.characterWrapper = wrapper
                    strongSelf.fetchCharacter(pageURL: nextPage)
            case .Failure(let error):
                print(error)
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

