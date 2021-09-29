//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft" : 3, "Medium" : 5, "Hard" : 7]
    var timerSeconds = 1
    var secondsPassed = 0
    var timer: Timer = Timer()
    var player: AVAudioPlayer = AVAudioPlayer.init()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        timerSeconds = eggTimes[hardness]!
        secondsPassed = 0
        timer.invalidate()
        self.titleLabel.text = hardness
        setProgress()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.setProgress()
            if (self.secondsPassed < self.timerSeconds) {
                print("\(self.secondsPassed) seconds.")
                self.secondsPassed += 1
            } else {
                self.timer.invalidate()
                self.titleLabel.text = "Done"
                self.playSound()
            }
        }
    }
    
    func setProgress() {
        progressBar.progress = Float(secondsPassed) / Float(timerSeconds)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: url!)
        self.player.play()
    }
}
