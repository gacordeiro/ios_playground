//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by gacordeiro LuizaLabs on 20/01/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviseLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = bmiValue ?? "0.0"
        adviseLabel.text = advice ?? "Dunno"
        backgroundView.backgroundColor = color ?? .magenta
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
