//
//  CardView.swift
//  GameOfSet
//
//  Created by Guilherme Cordeiro on 17/09/2019.
//  Copyright © 2019 Guilherme Cordeiro. All rights reserved.
//

import UIKit


class CardView: UIButton {
    private let HORIZONTAL_INSET: CGFloat = 5.0
    private let VERTICAL_INSET: CGFloat = 15.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 8.0
        layer.borderWidth = 2.0
        layer.borderColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentEdgeInsets = UIEdgeInsets(
            top: VERTICAL_INSET,
            left: HORIZONTAL_INSET,
            bottom: VERTICAL_INSET,
            right: HORIZONTAL_INSET
        )
        display(nil)
    }
    
    func display(_ cardOrNull: Card?, selected status: Game.SetStatus? = nil) {
        if let card = cardOrNull {
            titleLabel?.attributedText = card.getTitleWithShading()
            isHidden = false
        } else {
            isHidden = true
        }
    }
}

extension Card {
    private func getColor() -> UIColor {
        switch color {
        case .red: return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case .green: return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .blue: return #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
    }
    
    private func getShape() -> String {
        switch shape {
        case .triangle: return "▲"
        case .circle: return "●"
        case .square: return "■"
        }
    }
    
    private func applyShading(to title: String) -> NSAttributedString {
        var attrs: [NSAttributedString.Key : Any]? = nil
        switch shading {
        case .solid: attrs = [.foregroundColor : getColor().withAlphaComponent(1.0), .strokeWidth : -5, .strokeColor : getColor()]
        case .striped: attrs = [.foregroundColor : getColor().withAlphaComponent(0.25)]
        case .open: attrs = [.foregroundColor : getColor().withAlphaComponent(1.0), .strokeWidth : 5, .strokeColor : getColor()]
        }
        return NSAttributedString(string: title, attributes: attrs)
    }
    
    func getTitleWithShading() -> NSAttributedString {
        var title: String = ""
        for _ in 1...number {
            title += getShape()
        }
        return applyShading(to: title)
    }
}
