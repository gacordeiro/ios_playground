//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by gacordeiro LuizaLabs on 14/01/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    let quiz = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    ]
    
    private var questionNumber = 0
    private var score = 0
    private var scoreBonus = 1
    private var scorePenalty = -1
    
    private mutating func goToNextQuestion() -> Bool {
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func checkAnswer(_ userAswer: String) -> Result {
        let userGotItRight = userAswer == quiz[questionNumber].answer
        let quizContinues = userGotItRight ? goToNextQuestion() : true
        score += userGotItRight ? scoreBonus : scorePenalty
        return Result(userGotItRight, quizContinues)
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    struct Question {
        let text: String
        let answer: String
        
        init(q: String, a: String) {
            text = q
            answer = a
        }
    }
    
    struct Result {
        let userGotItRight: Bool
        let quizContinues: Bool
        
        init(_ userGotItRight: Bool, _ quizContinues: Bool) {
            self.userGotItRight = userGotItRight
            self.quizContinues = quizContinues
        }
    }
}
