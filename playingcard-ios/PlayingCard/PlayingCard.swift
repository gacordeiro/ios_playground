//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Guilherme Cordeiro on 12/09/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import Foundation


struct PlayingCard: CustomStringConvertible {
    var description: String { return "\(rank) \(suit)" }
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible {
        var description: String { return rawValue }
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        static var all: [Suit] = [.spades, .hearts, .diamonds, .clubs]
    }
    
    enum Rank: CustomStringConvertible {
        var description: String {
            switch self {
            case .ace: return "A"
            case .face(let face): return face.rawValue
            case .numeric: return String(order)
            }
        }
        case ace
        case face(Face)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let face): return face.order
            }
        }
        
        enum Face: String {
            case jack = "J"
            case queen = "Q"
            case king = "K"
            
            var order: Int {
                switch self {
                case .jack: return 11
                case .queen: return 12
                case .king: return 13
                }
            }
            
            static var all: [Face] = [.jack, .queen, .king]
        }
        
        static var all: [Rank] {
            var allRanks: [Rank] = [.ace]
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            for face in Rank.Face.all {
                allRanks.append(.face(face))
            }
            return allRanks
        }
    }
    
    struct Deck {
        private(set) var cards = [PlayingCard]()
        
        init() {
            for suit in PlayingCard.Suit.all {
                for rank in PlayingCard.Rank.all {
                    cards.append(PlayingCard(suit: suit, rank: rank))
                }
            }
        }
        
        mutating func draw() -> PlayingCard? {
            if cards.count > 0 {
                return cards.remove(at: cards.count.randomized())
            } else {
                return nil
            }
        }
    }
}
