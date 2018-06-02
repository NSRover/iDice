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
    let dice = DiceWala()

    override func viewDidLoad() {
        previousRoll.text = ""
        currentRoll.text = "Tap ↙"
        super.viewDidLoad()
    }

    @IBAction func roll(_ sender: Any) {
        let roll = dice.roll()
        if currentRoll.text != "Tap ↙" {
            previousRoll.text = currentRoll.text
        }
        currentRoll.text = "\(roll)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Your dice might explode soon")
    }
}

