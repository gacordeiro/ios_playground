//
//  Concentration.swift
//  Concentration
//
//  Created by Guilherme Cordeiro on 19/07/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var flipCount = 0
    private(set) var score = 0
    private(set) var cards = [Card]()
    private var remainingCards = 0
    private var indexOfOtherCard: Int? {
        get { return cards.indices.filter { (i) in cards[i].isFaceUp }.oneAndOnly }
        set { for index in cards.indices { cards[index].isFaceUp = (index == newValue) } }
    }
    
    init(numberOfPairOfCards: Int) {
        assert(numberOfPairOfCards > 0, "Concentration(\(numberOfPairOfCards)): invalid numberOfPairOfCards")
        remainingCards = numberOfPairOfCards * 2
        var seedCards = [Card]()
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            seedCards += [card, card]
        }
        
        var seed = seedCards.removeRandom()
        while seed != nil {
            cards.append(seed!)
            seed = seedCards.removeRandom()
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): Out of bounds")
        if !cards[index].isMatched {
            if (indexOfOtherCard != index) {
                flipCount += 1
            }
            if let matchIndex = indexOfOtherCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    remainingCards -= 2
                } else {
                    score += cards[index].getPenalty()
                    score += cards[matchIndex].getPenalty()
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOtherCard = index
            }
        }
    }
    
    func isNotOver() -> Bool { return remainingCards > 0 }
}

struct Card : Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int = getUniqueIdentifier()
    private var hasPenalty = false
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    mutating func getPenalty() -> Int {
        if (hasPenalty) {
            return -1
        } else {
            hasPenalty = true
            return 0
        }
    }
}
