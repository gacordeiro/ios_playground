//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by gacordeiro LuizaLabs on 21/01/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var split: Split?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = split {
            totalLabel.text = String(format: "%.2f", model.value)
            settingsLabel.text = String(format: "Split between %d people, with %d%% tip.", model.people, Int(model.tip * 100))
        }
    }

    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
