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
}

// add question data

let allQuestions: [Question] = [
    Question(question: "In what year was the Apple II introduced?", answers: [1: "1981", 2: "1977", 3: "1976", 4: "1979"], correctAnswer: 2),
    Question(question: "Elon Musk is from...", answers: [1: "South Africa", 2: "Hungary", 3: "The U.S.", 4: "Denmark"], correctAnswer: 1),
    Question(question: "Which of the following was NOT a founder of PayPal?", answers: [1: "Ken Howery", 2: "Elon Musk", 3: "Peter Thiel", 4: "Reid Hoffman"], correctAnswer: 4),
    Question(question: "What was the name of Tim Ferriss' first company that originally went on to inspire 'The Four Hour Work Week?'", answers: [1: "Uber", 2: "Drug Dealing for Fun And Profit", 3: "BrainQUICKEN", 4: "MetaBrain"], correctAnswer: 3),
    Question(question: "The Shopify HQ's are located in what city?", answers: [1: "San Francisco", 2: "Los Angeles", 3: "Ottowa", 4: "Toronto"], correctAnswer: 3),
    Question(question: "What does MRR stand for?", answers: [1: "Main Rental Rooms", 2: "Monthly Recurring Revenue", 3: "Monthly Run Rate", 4: "Mark Read Red"], correctAnswer: 2),
    Question(question: "Richard Branson has started this many companies...", answers: [1: "2", 2: "13", 3: "100", 4: "400+"], correctAnswer: 4)
]

// generating a set based on all questions, and assigning an index number to each.

var roundQuestions = [Int]()
var questionIndex = 0


func generateRoundQuestions() {
    var i = 0
    
    while i < allQuestions.count {
        roundQuestions.append(i)
        i += 1
    }
}

// chooses a question index # and temporarily removes it from the question index.

func nextQuestion() {
    questionIndex = roundQuestions.remove(at: GKRandomSource.sharedRandom().nextInt(upperBound: roundQuestions.count))
}
