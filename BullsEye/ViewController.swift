//
//  ViewController.swift
//  Bulls''Eye
//
//  Created by Frederico on 16/01/2017.
//  Copyright © 2017 Fuad Adetoro. All rights reserved.
// 

import UIKit
import QuartzCore

class ViewController: UIViewController {

    // Outlets for the labels & the slider
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    // Default values for score, round, currentValue & targetValue
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the slider animation
        setUpSliderCustomization()
        
        // Set scoreLabel & roundLabel to beginning values.
        scoreLabel.text = "0"
        roundLabel.text = "1"
        
        // Start Game
        startNewGame()
        
        // Update value to current value.
        updateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func showAlert(_ sender: Any) {
        // Created a difference constant to check if the value is close to the target. Abs also provides extra functionality, so if the value is a negative number then it will turn positive.
        let difference = abs(currentValue - targetValue)
        
        // Calculate points using the difference constant, minus 100 from the difference and it will give you the value of how far you was off or on.
        var points = 100 - difference
        
        // Created empty title variable
        var title: String
        // If the user was spot on and got it on the 'BullsEye' then set the title to perfect and also award the user with 100 points.
        if difference == 0 {
            title = "Perfect!"
            points += 100
        // If the user was only 5 off then set the title as you almost had it
        } else if difference < 5 {
            title = "You almost had it"
            
            // Award the user 50 free points if they're just one point away from the 'bullseye'
            if difference == 1 {
                points += 50
            }
        // If the difference is more than five but less than 11 then set the title to Pretty good!
        } else if difference < 10 {
            title = "Pretty good!"
        // If all else fails then set the title to Not even close as the user wasn't close.
        } else {
            title = "Not even close..."
        }
        
        // Update the score variable to points
        score += points
        
        // Print out the points the user got in the round.
        let message = "You scored \(points) points"
        
        // Display the alert using the title and message.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            // Closure here so we wait for the user to click OK before starting the new round and updating the label.
            self.startNewRound()
            self.updateLabel()
        }
        alert.addAction(action)
        // Present the alertController.
        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ sender: UISlider) {
        // update currentValue everytime the slider moves.
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func startOver(_ sender: Any) {
        
        // Start new round when the restart button is picked.
        startNewGame()
        updateLabel()
        
        
        // animate the restart happening, the transition allows the values to animate as it restarts. If the slider.value is on 100 when the start over function is clicked then it will fade back to the default value, the fade effect also happens to the score & round labels.
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewGame(){
        // Reset all values and start new round
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound(){
        // Create new random value and make sure it goes up to 100
        targetValue = 1 + Int(arc4random_uniform(100))
        // Update currentValue to be 50 when the round restarts so the bullbar can go back to the center
        currentValue = 50
        // update slider.value to currentValue
        slider.value = Float(currentValue)
        // increment round when new round starts
        round += 1
    }
    
    func updateLabel(){
        // Update targetLabel, scoreLabel & roundLabel to the values of the instant variables - targetValue, score & round
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func setUpSliderCustomization(){
        
        // Set thumb image for the slider.
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        // Set thumb highlighted image
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        // Set the image for the slider for the left position
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        // Set the image for the slider for the right position
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
}

