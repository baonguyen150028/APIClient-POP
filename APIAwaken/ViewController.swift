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

    override func viewDidLoad() {
        super.viewDidLoad()
        awakenClient.fetchCharacter(completion: { result in
            switch result {
            case .Success(let characters) :
                for character in characters {
                    print(character.name)
                }
            case .Failure(let error):
                print(error)
            }
            })
    }


}

