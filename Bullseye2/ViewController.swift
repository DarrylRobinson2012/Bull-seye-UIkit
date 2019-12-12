//
//  ViewController.swift
//  Bullseye2
//
//  Created by Darryl Robinson on 12/9/19.
//  Copyright © 2019 Darryl Robinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetNumber: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        let thumbImage = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImage, for: .normal)
        
        let thumbHiglighted = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbHiglighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

        // Do any additional setup after loading the view.
    }
    @IBAction func showAlert() {
           
       score += calculatePoints() + calcuateBonus()
        
      
        
        let message = "You scored \(calculatePoints()) points plus \(calcuateBonus()) points"
        let alert = UIAlertController(title: alertTitle(), message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })
           
           alert.addAction(action)
           
           present(alert, animated: true, completion: nil)
        
       
        
           
       }
    
 
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded())

        
    }
    
    @IBAction func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
    
    func calcuateBonus() -> Int {
       var bonus = 0
        if calculatePoints() == 100 {
            bonus =  100
        } else if calculatePoints() == 99 {
            bonus = 50
        }
        return bonus
    }
    
    func calculatePoints() -> Int{
        let difference = 100 - abs(currentValue - targetValue)
        
        return difference
        
    }
    
    func startNewRound() {
       targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabel()
    }
    
    func updateLabel() {
        targetNumber.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    
       func alertTitle() -> String {
           let difference = abs(currentValue - targetValue)
           let title: String
           
        if difference == 0 {
               title = "Perfect"
               
           } else if difference <= 5 {
               title = "Very Close"
           } else if difference <= 10 {
               title = "Not Bad"
           } else {
               title = "Are you even trying"
           }
           return title
           
       }

}

