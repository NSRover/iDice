//
//  DiceWala.swift
//  iDice
//
//  Created by Nirbhay Agarwal on 02/06/18.
//  Copyright © 2018 NSRover. All rights reserved.
//

import Foundation

class DiceWala {

    let sortedProbabilityDistribution:[Double]!
    let probabilityLookup:[Double:Int]!
    let probabilitiesSum:Double!

    func roll() -> Int {
        let randomNumber = probabilitiesSum * Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
        for limit in sortedProbabilityDistribution {
            if randomNumber <= limit {
                return probabilityLookup[limit]!
            }
        }
        return 4_20 //🍁
    }

    init() {
        let generatedResults = DiceWala.sumAndLookUpForDoubleDice()
        probabilitiesSum = generatedResults.sum
        probabilityLookup = generatedResults.lookupTable
        sortedProbabilityDistribution = probabilityLookup.keys.sorted()
    }

    static func sumAndLookUpForDoubleDice() -> (sum:Double, lookupTable:[Double:Int]) {
        let singleRollProbability = 1.0/11

        //Probability ditribution
        var probabilities:[Int:Double] = [:]
        for i in 1...6 {
            for j in 1...6 {
                let total = i + j
                if let existingCount = probabilities[total] {
                    probabilities[total] = existingCount + singleRollProbability
                } else {
                    probabilities[total] = singleRollProbability
                }
            }
        }
        let probabilitiesSum = probabilities.values.reduce(0, +)

        //LookUp table
        var lookup:[Double:Int] = [:]
        var limit:Double = 0
        for roll in 2...12 {
            let rollProbability = probabilities[roll]!
            limit += rollProbability
            lookup[limit] = roll
        }

        return (probabilitiesSum, lookup)
    }
}
