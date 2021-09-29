//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by gacordeiro LuizaLabs on 20/01/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct BMI {
    let value: Float
    let advice: String
    let color: UIColor
}

struct CalculatorBrain {
    private var bmi: BMI?
    
    mutating func calculateBMI(h height: Float, w weight: Float) {
        let value = weight / pow(height, 2)
        let advice = calculateAdvice(for: value)
        let color = calculateColor(for: value)
        bmi = BMI(value: value, advice: advice, color: color)
        print(advice)
    }
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? 0.0)
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "Uh-oh"
    }
    
    func getColor() -> UIColor? {
        return bmi?.color
    }
    
    private func calculateAdvice(for bmi: Float) -> String {
        switch bmi {
        case 0..<18.5:
            return "Eat more pies!"
        case 18.5...24.9:
            return "Fit as a fiddle"
        default:
            return "Eat less pies!"
        }
    }
    
    private func calculateColor(for bmi: Float) -> UIColor {
        switch bmi {
        case 0..<18.5:
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 18.5...24.9:
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        default:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}

