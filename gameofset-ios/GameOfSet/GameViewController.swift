//
//  ViewController.swift
//  GameOfSet
//
//  Created by Guilherme Cordeiro on 12/09/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    private var game: Game!
    
    @IBOutlet var cardButtons: [CardView]! {
        didSet {
            newGame()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func newGameClicked(_ sender: UIButton) {
        print("newGameClicked")
        newGame()
    }
    
    func newGame() {
        print("New Game")
        game = Game()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        //TODO: test draw
        print("updateViewFromModel")
        print("drawnCards: \(game.drawnCards.count)")
        for index in game.drawnCards.indices {
            cardButtons[index].display(game.drawnCards[index])
        }
    }
}

