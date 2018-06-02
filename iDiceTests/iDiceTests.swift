//
//  iDiceTests.swift
//  iDiceTests
//
//  Created by Nirbhay Agarwal on 02/06/18.
//  Copyright © 2018 NSRover. All rights reserved.
//

import XCTest
@testable import iDice

class iDiceTests: XCTestCase {

    /// Test to see if the distribution is natural for a 2 dice game
    func testDistribution() {
        let diceWala = DiceWala()
        var distribution:[Int:Int] = [:]

        //Rolling the 🎲 lots of times
        for _ in 0...10_000 {
            let roll = diceWala.roll()
            if let existingCount = distribution[roll] {
                distribution[roll] = existingCount + 1
            } else {
                distribution[roll] = 1
            }
        }

        //Sorting the rolls by their occurance
        let sortedRollDistribution = distribution.sorted(by: { (first, second) -> Bool in
            first.value < second.value
        })

        //Mapping occurances to a simple sorted array
        let sortedRolls = sortedRollDistribution.map { (pair) -> Int in
            pair.key
        }

        //Checking to see if probability is natural
        // 2/12 - 3/11 - 4/10 - 5/9 - 6/8 - 💩
        for i in 0...10 {
            switch i {
            case 0, 1:
                XCTAssert(sortedRolls[i] == 2 || sortedRolls[i] == 12)
            case 2, 3:
                XCTAssert(sortedRolls[i] == 3 || sortedRolls[i] == 11)
            case 4, 5:
                XCTAssert(sortedRolls[i] == 4 || sortedRolls[i] == 10)
            case 6, 7:
                XCTAssert(sortedRolls[i] == 5 || sortedRolls[i] == 9)
            case 8, 9:
                XCTAssert(sortedRolls[i] == 6 || sortedRolls[i] == 8)
            case 10:
                XCTAssert(sortedRolls[i] == 7)
            default:
                break
            }
        }
    }
}
