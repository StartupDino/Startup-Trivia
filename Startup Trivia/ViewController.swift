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
    
    
    /* TO-DO!!
 
    Add sounds
    Add inputs for # of round questions?
    Add timer functionality
     */
    
    
    // buttons!
   
    @IBOutlet weak var questionArea: UILabel!
    @IBOutlet weak var resultArea: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // the variables!
    
    var roundQuestions = [Int]()
    var questionIndex = 0
    var questionsPerRound = 4
    var questionsAsked = 0
    var score = 0

    
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
    
    func generateRoundQuestions() {
        var i = 0
        
        while i < allQuestions.count {
            roundQuestions.append(i)
            i += 1
        }
    }
    
    // starts round

    @IBAction func startRound() {
        answerButtonOne.isHidden = false
        answerButtonTwo.isHidden = false
        answerButtonThree.isHidden = false
        answerButtonFour.isHidden = false
        playAgainButton.isHidden = true
        resultArea.isHidden = true
        
        answerButtonOne.alpha = 1
        answerButtonTwo.alpha = 1
        answerButtonThree.alpha = 1
        answerButtonFour.alpha = 1

        
        print(roundQuestions)

        questionIndex = roundQuestions.remove(at: GKRandomSource.sharedRandom().nextInt(upperBound: roundQuestions.count))
        
        print(roundQuestions)
        print(questionIndex)
        print(questionsAsked)
        
        questionArea.text = allQuestions[questionIndex].question
        answerButtonOne.setTitle(allQuestions[questionIndex].answers[1], for: UIControlState.normal)
        answerButtonTwo.setTitle(allQuestions[questionIndex].answers[2], for: UIControlState.normal)
        answerButtonThree.setTitle(allQuestions[questionIndex].answers[3], for: UIControlState.normal)
        answerButtonFour.setTitle(allQuestions[questionIndex].answers[4], for: UIControlState.normal)
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        questionsAsked += 1
        print(questionsAsked)
        
        let answer = allQuestions[questionIndex].correctAnswer
        
        if (sender == answerButtonOne && answer == 1) || (sender == answerButtonTwo && answer == 2) || (sender == answerButtonThree && answer == 3) || (sender == answerButtonFour && answer == 4) {
            resultArea.text = "Yes yes yes! \(allQuestions[questionIndex].answers[answer]!) is correct!"
            score += 1
        }
            else {
            resultArea.text = "Nope. Sorry. It's \(allQuestions[questionIndex].answers[answer]!)."
            }
        
        // dimming incorrect answers
        
        if allQuestions[questionIndex].correctAnswer == 1 {
            answerButtonTwo.alpha = 0.3
            answerButtonThree.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if allQuestions[questionIndex].correctAnswer == 2 {
            answerButtonOne.alpha = 0.3
            answerButtonThree.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if allQuestions[questionIndex].correctAnswer == 3 {
            answerButtonOne.alpha = 0.3
            answerButtonTwo.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if allQuestions[questionIndex].correctAnswer == 4 {
            answerButtonOne.alpha = 0.3
            answerButtonTwo.alpha = 0.3
            answerButtonThree.alpha = 0.3
        }
        
        resultArea.isHidden = false
        
        addDelay()

    }
    
    // Delayed transitions between questions, and displaying final score
    
    func loadNextRound() {
        
        if questionsAsked == 4 {
            displayScore()
        } else {
            startRound()
        }
    }
    
    func addDelay () {
        let time = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.loadNextRound()
        }
    }
    
    func displayScore() {
        score = 0
        questionsAsked = 0
        
        switch score {
        case 0:
            questionArea.text = "\(score)? That's pretty damn bad."
        case 1: questionArea.text = "Well, \(score) means you could have technically done worse..."
        case 2: questionArea.text = "Ok. \(score) is respectable. I guess."
        case 3: questionArea.text = "Woah. \(score) is an uberdoerpreneuer score."
        case 4: questionArea.text = "Holy CEO status Batman! \(score) is a grok score."
        default: break
        }
        
        questionIndex = roundQuestions.remove(at: GKRandomSource.sharedRandom().nextInt(upperBound: roundQuestions.count))
        generateRoundQuestions()
        
        answerButtonOne.isHidden = true
        answerButtonTwo.isHidden = true
        answerButtonThree.isHidden = true
        answerButtonFour.isHidden = true
        resultArea.isHidden = true
        playAgainButton.isHidden = false
        
        playAgainButton.setTitle("Again?", for: UIControlState.normal)
        
    }
    
    // loading sound effects
    
    func loadSounds() {
        <#function body#>
    }
}

