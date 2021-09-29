//
//  ViewController.swift
//  PlayingCard
//
//  Created by Guilherme Cordeiro on 12/09/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCard.Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print(card)
            }
        }
    }
}
