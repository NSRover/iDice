//
//  ViewController.swift
//  iDice
//
//  Created by Nirbhay Agarwal on 02/06/18.
//  Copyright © 2018 NSRover. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var previousRoll: UILabel!
    @IBOutlet weak var currentRoll: UILabel!
    @IBOutlet weak var transitionRoll: UILabel!
    @IBOutlet weak var diceButton: UIButton!
    let dice = DiceWala()

    override func viewDidLoad() {
        previousRoll.text = ""
        currentRoll.text = "Tap ↙"
        transitionRoll.alpha = 0
        super.viewDidLoad()
    }

    @IBAction func roll(_ sender: Any) {
        let midX = diceButton.frame.origin.x + diceButton.frame.size.width / 2
        let midY = diceButton.frame.origin.y + diceButton.frame.size.height / 2
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - 15, y: midY - 10)
        animation.toValue = CGPoint(x: midX + 10, y: midY + 15)
        diceButton.layer.add(animation, forKey: "position")

        DispatchQueue.main.asyncAfter(deadline: .now() + (0.06 * 4 * 2)) {
            self.actualRoll()
        }
    }

    func actualRoll() {
        let roll = dice.roll()
        transitionRoll.text = currentRoll.text
        if currentRoll.text != "Tap ↙" {
            transitionRoll.center = currentRoll.center
            transitionRoll.isHidden = false
            transitionRoll.alpha = 1.0
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.transitionRoll.alpha = 0.5
                            self.transitionRoll.center = self.previousRoll.center
            }) { (complete) in
                self.previousRoll.text = self.transitionRoll.text
                self.transitionRoll.alpha = 0
            }
        }
        currentRoll.text = "\(roll)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Your dice might explode soon")
    }
}

