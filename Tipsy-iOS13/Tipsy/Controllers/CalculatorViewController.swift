//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

struct Split {
    var people: Int
    var tip: Float
    var value: Float
}

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var total: Float = 0.0
    var people: Int = 2
    var tip: Float = 0.1
    var value: Float = 0.0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        tip = getPercentage(for: sender.currentTitle ?? "")
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        billTextField.endEditing(true)
        total = Float(billTextField.text ?? "0.0") ?? 0.0
        people = Int(splitNumberLabel.text ?? "2") ?? 2
        value = (total * (1 + tip)) / Float(people)
        performSegue(withIdentifier: "calculate", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calculate" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.split = Split(people: people, tip: tip, value: value)
        }
    }
    
    private func getPercentage(for button: String) -> Float {
        switch button {
        case "20%":
            return 0.2
        case "10%":
            return 0.1
        default:
            return 0.0
        }
    }
}

