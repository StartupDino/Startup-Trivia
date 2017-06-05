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
    
    // the buttons & labels!
   
    @IBOutlet weak var questionArea: UILabel!
    @IBOutlet weak var resultArea: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // the variables!
    
    var questionsPerRound = 4
    var questionsAsked = 0
    var score = 0
    var gameSound: SystemSoundID = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        primeTheApp()
        playGameStartSound()    
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
    
    // starts round and asks a question from the generated index.

    @IBAction func startRound() {
                
        nextQuestion()
     
        questionArea.text = allQuestions[questionIndex].question
        answerButtonOne.setTitle(allQuestions[questionIndex].answers[1], for: UIControlState.normal)
        answerButtonTwo.setTitle(allQuestions[questionIndex].answers[2], for: UIControlState.normal)
        answerButtonThree.setTitle(allQuestions[questionIndex].answers[3], for: UIControlState.normal)
        answerButtonFour.setTitle(allQuestions[questionIndex].answers[4], for: UIControlState.normal)
        
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
    
    // Delayed transitions between questions
    
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
    
    // Displays final score and resets score, index, etc.
    
    func displayScore() {
        
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
        
        score = 0
        questionsAsked = 0
    }
    
    // loading sound effects
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

