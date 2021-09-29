//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    
    var storyBrain: StoryBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func choiseMade(_ sender: UIButton) {
        storyBrain.choose(sender.currentTitle!)
        updateUI()
    }
    
    func updateUI() {
        let story = storyBrain.getStory()
        storyLabel.text = story.title
        choiceButton1.setTitle(story.choice1, for: .normal)
        choiceButton2.setTitle(story.choice2, for: .normal)
    }
}

