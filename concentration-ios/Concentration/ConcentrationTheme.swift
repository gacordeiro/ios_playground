//
//  ConcentrationTheme.swift
//  Concentration
//
//  Created by Guilherme Cordeiro on 02/09/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import UIKit

private let themeOptions: [ConcentrationTheme] = [
    ConcentrationTheme(
        emojiChoices: ["👻", "🎃", "🦇", "💀", "😈", "👿", "👾", "👺", "👹", "🤡"],
        viewBackground: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        cardBack: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    ),
    ConcentrationTheme(
        emojiChoices: ["🥺", "🤮", "😂", "🤢", "🤧", "🤯", "😭", "😍", "🤪", "😆"],
        viewBackground: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1),
        cardBack: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),
        textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    ),
    ConcentrationTheme(
        emojiChoices: ["🧞‍♀️", "🧞‍♂️", "🧜‍♀️", "🧜‍♂️", "🧛‍♀️", "🧛‍♂️", "🧚‍♀️", "🧚‍♂️", "🧟‍♂️", "🧟‍♀️"],
        viewBackground: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),
        cardBack: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
        textBackground: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    )
]

struct ConcentrationTheme {
    var viewBackground: UIColor
    var cardBack: UIColor
    var cardFront: UIColor
    private var textColor: UIColor
    private var textAttrs: [NSAttributedString.Key:Any]
    private var emojiChoices: [String]
    private var emojiInPlay = [Card:String]()
    
    init(
        emojiChoices: [String],
        viewBackground: UIColor,
        cardBack: UIColor,
        cardFront: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
        textColor: UIColor? = nil,
        textBackground: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0),
        emojiInPlay: [Card:String] = [Card:String]()
    ) {
        self.viewBackground = viewBackground
        self.cardBack = cardBack
        self.cardFront = cardFront
        self.textColor = textColor ?? cardBack
        self.textAttrs = [
            .backgroundColor : textBackground
        ]
        self.emojiChoices = emojiChoices
        self.emojiInPlay = emojiInPlay
    }
    
    mutating func getEmoji(for card: Card) -> String {
        if emojiInPlay[card] == nil {
            emojiInPlay[card] = emojiChoices.removeRandom()
        }
        return emojiInPlay[card] ?? "?"
    }
    
    func applyAttributes(to label: UILabel) {
        applyAttributes(to: label, with: label.text.orEmpty())
    }
    
    func applyAttributes(to label: UILabel, with text: String) {
        label.textColor = textColor
        label.attributedText = NSAttributedString(string: text, attributes: textAttrs)
    }
    
    static func new(randomize: Bool = false) -> ConcentrationTheme {
        return randomize ? themeOptions.randomElement()! : themeOptions[0]
    }
}
