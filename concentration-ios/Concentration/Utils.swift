//
//  Utils.swift
//  Concentration
//
//  Created by Guilherme Cordeiro on 04/09/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import Foundation

extension Int {
    func randomized() -> Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

extension Array {
    mutating func removeRandom() -> Element? {
        return count == 0 ? nil : remove(at: count.randomized())
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self ?? ""
    }
}
