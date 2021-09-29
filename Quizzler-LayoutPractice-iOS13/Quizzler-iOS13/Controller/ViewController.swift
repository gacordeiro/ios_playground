//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    private var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartQuiz()
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        restartQuiz()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let result = quizBrain.checkAnswer(userAnswer)
        
        if result.userGotItRight {
            sender.flashRight()
        } else {
            sender.flashWrong()
        }
        
        if result.quizContinues {
            updateUI()
        } else {
            questionLabel.text = "Congratulations!"
            trueButton.isHidden = true
            falseButton.isHidden = true
            restartButton.isHidden = false
            progressBar.progress = 1
        }
    }
    
    private func restartQuiz() {
        quizBrain = QuizBrain()
        trueButton.isHidden = false
        falseButton.isHidden = false
        restartButton.isHidden = true
        updateUI()
    }
    
    private func updateUI() {
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
    }
}

extension UIButton {
    func flashRight() {
        flash(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.3310648545))
    }
    
    func flashWrong() {
        flash(#colorLiteral(red: 0.5690609813, green: 0.1094286963, blue: 0.09618351609, alpha: 0.3290346747))
    }
    
    func flash(_ color: UIColor) {
        backgroundColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { self.backgroundColor = UIColor.clear }
    }
}
