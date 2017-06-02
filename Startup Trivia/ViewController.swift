//
//  ViewController.swift
//  Startup Trivia
//
//  Created by Pete McPherson on 5/31/17.
//  Copyright © 2017 Pete McPherson. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    
    
    // buttons!
   
    @IBOutlet weak var questionArea: UILabel!
    @IBOutlet weak var resultArea: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // the variables!
    
    var roundQuestions = [Question]()
    var questionIndex = 0

    
    // the data!
    
    let allQuestions: [Question] = [
        Question(question: "In what year was the Apple II introduced?", answers: [1: "1981", 2: "1977", 3: "1976", 4: "1979"], correctAnswer: 2),
        Question(question: "Elon Musk is from...", answers: [1: "South Africa", 2: "Hungary", 3: "The U.S.", 4: "Denmark"], correctAnswer: 1),
        Question(question: "Which of the following was NOT a founder of PayPal?", answers: [1: "Ken Howery", 2: "Elon Musk", 3: "Peter Thiel", 4: "Reid Hoffman"], correctAnswer: 4),
        Question(question: "What was the name of Tim Ferriss' first company that originally went on to inspire 'The Four Hour Work Week?'", answers: [1: "Uber", 2: "Drug Dealing for Fun And Profit", 3: "BrainQUICKEN", 4: "MetaBrain"], correctAnswer: 3),
        Question(question: "The Shopify HQ's are located in what city?", answers: [1: "San Francisco", 2: "Los Angeles", 3: "Ottowa", 4: "Toronto"], correctAnswer: 3)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        primeTheApp()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // sets up the welcome screen and choose 4 random questions
    
    func primeTheApp() {
        answerButtonOne.isHidden = true
        answerButtonTwo.isHidden = true
        answerButtonThree.isHidden = true
        answerButtonFour.isHidden = true
        resultArea.isHidden = true
        questionArea.text = "Are you a triviapreneur? Time to find out."
        generateRoundQuestions()

    }
    
    func generateRoundQuestions() -> [Question] {
        var i = 0
        
        while i < 4 {
            i += 1
            roundQuestions.append(allQuestions[GKRandomSource.sharedRandom().nextInt(upperBound: allQuestions.count)])
        }
        return roundQuestions
    }
    
    // starts round

    @IBAction func startRound() {
        answerButtonOne.isHidden = false
        answerButtonTwo.isHidden = false
        answerButtonThree.isHidden = false
        answerButtonFour.isHidden = false
        playAgainButton.isHidden = true
        
        answerButtonOne.alpha = 1
        answerButtonTwo.alpha = 1
        answerButtonThree.alpha = 1
        answerButtonFour.alpha = 1

        
        print(roundQuestions)
        
        questionArea.text = roundQuestions[questionIndex].question
        answerButtonOne.setTitle(roundQuestions[questionIndex].answers[1], for: UIControlState.normal)
        answerButtonTwo.setTitle(roundQuestions[questionIndex].answers[2], for: UIControlState.normal)
        answerButtonThree.setTitle(roundQuestions[questionIndex].answers[3], for: UIControlState.normal)
        answerButtonFour.setTitle(roundQuestions[questionIndex].answers[4], for: UIControlState.normal)
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        print(questionIndex)
        
        if (sender == answerButtonOne && roundQuestions[questionIndex].correctAnswer == 1) || (sender == answerButtonTwo && roundQuestions[questionIndex].correctAnswer == 2) || (sender == answerButtonThree && roundQuestions[questionIndex].correctAnswer == 3) || (sender == answerButtonFour && roundQuestions[questionIndex].correctAnswer == 4) {
            print("right")
            resultArea.text = "Yes yes yes! \(roundQuestions[questionIndex].answers[roundQuestions[questionIndex].correctAnswer]!) is correct!"
        }
            else {
                print("nope")
            resultArea.text = "Nope. Sorry. It's \(roundQuestions[questionIndex].answers[roundQuestions[questionIndex].correctAnswer]!)."
            }
        
        // dimming incorrect answers
        
        if roundQuestions[questionIndex].correctAnswer == 1 {
            answerButtonTwo.alpha = 0.3
            answerButtonThree.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if roundQuestions[questionIndex].correctAnswer == 2 {
            answerButtonOne.alpha = 0.3
            answerButtonThree.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if roundQuestions[questionIndex].correctAnswer == 3 {
            answerButtonOne.alpha = 0.3
            answerButtonTwo.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if roundQuestions[questionIndex].correctAnswer == 4 {
            answerButtonOne.alpha = 0.3
            answerButtonTwo.alpha = 0.3
            answerButtonThree.alpha = 0.3
        }
        
        resultArea.isHidden = false
        
        
        
        questionIndex += 1

    }

}

