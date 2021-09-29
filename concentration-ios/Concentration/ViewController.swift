//
//  ViewController.swift
//  Concentration
//
//  Created by Guilherme Cordeiro on 25/03/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var theme = ConcentrationTheme.new()
    private lazy var game = newGame()
    
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else { print("invalid cardButtons index") }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        theme = ConcentrationTheme.new(randomize: true)
        game = newGame()
    }
    
    func newGame() -> Concentration {
        game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
        view.backgroundColor = theme.viewBackground
        theme.applyAttributes(to: gameOverLabel)
        updateViewFromModel()
        return game
    }
    
    func updateViewFromModel() {
        theme.applyAttributes(to: flipCountLabel, with: "Flips: \(game.flipCount)")
        theme.applyAttributes(to: scoreLabel, with: "Score: \(game.score)")
        gameOverLabel.isHidden = game.isNotOver()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp && game.isNotOver() {
                button.setTitle(theme.getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = theme.cardFront
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : theme.cardBack
            }
        }
    }
}
