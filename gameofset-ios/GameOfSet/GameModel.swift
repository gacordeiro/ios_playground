//
//  CardModel.swift
//  GameOfSet
//
//  Created by Guilherme Cordeiro on 12/09/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import Foundation

struct Card: Hashable {
    let number: Int
    let shape: Shape
    let shading: Shading
    let color: Color
    
    func isSet(with cardA: Card, and cardB: Card) -> Bool {
        return shapeSet(with: cardA.shape, and: cardB.shape) || shadingSet(with: cardA.shading, and: cardB.shading) || colorSet(with: cardA.color, and: cardB.color)
    }
    
    private func shapeSet(with shapeA: Shape, and shapeB: Shape) -> Bool {
        return (shape == shapeA && shape == shapeB) || (shape != shapeA && shape != shapeB && shapeA != shapeB)
    }
    
    private func shadingSet(with shadingA: Shading, and shadingB: Shading) -> Bool {
        return (shading == shadingA && shading == shadingB) || (shading != shadingA && shading != shadingB && shadingA != shadingB)
    }
    
    private func colorSet(with colorA: Color, and colorB: Color) -> Bool {
        return (color == colorA && color == colorB) || (color != colorA && color != colorB && colorA != colorB)
    }
    
    enum Shape {
        case triangle
        case circle
        case square
        static let all: [Shape] = [.triangle, .circle, .square]
    }
    
    enum Shading {
        case solid
        case striped
        case open
        static let all: [Shading] = [.solid, .striped, .open]
    }
    
    enum Color {
        case red
        case green
        case blue
        static let all: [Color] = [.red, .green, .blue]
    }
}

private struct Deck {
    private(set) var cards = [Card]()
    
    init() {
        print("Deck init()")
        for number in 1...3 {
            for shape in Card.Shape.all {
                for shading in Card.Shading.all {
                    for color in Card.Color.all {
                        let card = Card(number: number, shape: shape, shading: shading, color: color)
                        cards.append(card)
                    }
                }
            }
        }
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.randomized())
        } else {
            return nil
        }
    }
}

struct Game {
    private(set) var score = 0
    private(set) var status: SetStatus = .maybe
    private(set) var drawnCards = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var hintCards = [Card]()
    private var deck = Deck()
    private var initialHand: Int
    private var maxHand: Int
    private var drawSize: Int
    private let BONUS_RIGHT_SELECTION = 3
    private let PENALTY_WRONG_SELECTION = 5
    private let PENALTY_UNSELECTION = 1
    private let PENALTY_DRAW_WITH_SET = 3
    
    init(initialHand: Int = 12, maxHand: Int = 24, drawSize: Int = 3) {
        print("Game init()")
        self.initialHand = initialHand
        self.maxHand = maxHand
        self.drawSize = drawSize
        assert(initialHand <= deck.cards.count || maxHand <= deck.cards.count, "Invalid init parameters for Game")
        draw(initialHand)
    }
    
    mutating func select(_ card: Card) {
        print("select: \(card)")
        if (selectedCards.count >= 3) {
            selectedCards.removeAll(keepingCapacity: true)
        }
        selectedCards.append(card)
        scoreGame()
    }
    
    mutating func unselect(_ card: Card) {
        print("unselect: \(card)")
        if let position = selectedCards.firstIndex(of: card) {
            selectedCards.remove(at: position)
            score -= PENALTY_UNSELECTION
        }
    }
    
    mutating func drawMore() -> Bool {
        print("drawMore()")
        if deck.cards.count > 0 {
            if isSetAvailable() {
                score -= PENALTY_DRAW_WITH_SET
            }
            draw(drawSize)
            return true
        } else {
            return false
        }
    }
    
    mutating func isSetAvailable() -> Bool {
        print("isSetAvailable()")
        checkForSet()
        return hintCards.count == 3
    }
    
    private mutating func scoreGame() {
        print("scoreGame()")
        if selectedCards.count == 3 {
            if selectedCards[0].isSet(with: selectedCards[1], and: selectedCards[2]) {
                score += BONUS_RIGHT_SELECTION
                status = .yes
            } else {
                score -= PENALTY_WRONG_SELECTION
                status = .no
            }
        }
        status = .maybe
    }
    
    private mutating func checkForSet() {
        print("checkForSet()")
        hintCards.removeAll(keepingCapacity: true)
        for a in 0...drawnCards.count {
            for b in a...drawnCards.count {
                for c in b...drawnCards.count {
                    if drawnCards[a].isSet(with: drawnCards[b], and: drawnCards[c]) {
                        hintCards = [drawnCards[a], drawnCards[b], drawnCards[c]]
                    }
                }
            }
        }
    }
    
    private mutating func draw(_ count: Int) {
        print("draw: \(count)")
        for _ in 1...count {
            if let card = deck.draw() { drawnCards.append(card) }
        }
    }
    
    enum SetStatus {
        case yes
        case no
        case maybe
    }
}
