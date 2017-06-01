//
//  Questions.swift
//  Startup Trivia
//
//  Created by Pete McPherson on 5/31/17.
//  Copyright © 2017 Pete McPherson. All rights reserved.
//

import Foundation
import GameKit

struct Question {
    
    let question: String
    let answers: [Int: String]
    let correctAnswer: Int
    
    let allQuestions: [Question] = [
        Question(question: "In what year was the Apple II introduced?", answers: [1: "1981", 2: "1977", 3: "1976", 4: "1979"], correctAnswer: 2),
        Question(question: "Elon Musk is from...", answers: [1: "South Africa", 2: "Hungary", 3: "The U.S.", 4: "Denmark"], correctAnswer: 1),
        Question(question: "Which of the following was NOT a founder of PayPal?", answers: [1: "Ken Howery", 2: "Elon Musk", 3: "Peter Thiel", 4: "Reid Hoffman"], correctAnswer: 4),
        Question(question: "What was the name of Tim Ferriss' first company that originally went on to inspire 'The Four Hour Work Week?'", answers: [1: "Uber", 2: "Drug Dealing for Fun And Profit", 3: "BrainQUICKEN", 4: "MetaBrain"], correctAnswer: 3),
        Question(question: "Shopify HQ are in what city?", answers: [1: "San Francisco", 2: "Los Angeles", 3: "Ottowa", 4: "Toronto"], correctAnswer: 3)
    ]
    
    func generateRoundQuestions() -> [Question] {
        var roundQuestions = [Question]()
        var i = 0
        
        while i < 4 {
            i += 1
            roundQuestions.append(allQuestions[GKRandomSource.sharedRandom().nextInt(upperBound: allQuestions.count)])
        }
        return roundQuestions
    }
    
//    func returnQuestion() -> String {
//        return question
//    }
//    
//    func returnAnswerNum() -> Int {
//        return correctAnswer
//    }
}
