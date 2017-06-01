//
//  ViewController.swift
//  Startup Trivia
//
//  Created by Pete McPherson on 5/31/17.
//  Copyright © 2017 Pete McPherson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // buttons!
   
    @IBOutlet weak var questionArea: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        primeTheApp()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // sets up the welcome screen
    
    func primeTheApp() {
        answerButtonOne.isHidden = true
        answerButtonTwo.isHidden = true
        answerButtonThree.isHidden = true
        answerButtonFour.isHidden = true
        questionArea.text = "Are you a triviapreneur? Time to find out."
    }

    @IBAction func startRound() {
        answerButtonOne.isHidden = false
        answerButtonTwo.isHidden = false
        answerButtonThree.isHidden = false
        answerButtonFour.isHidden = false
        playAgainButton.isHidden = true
        
    }

}

