//
//  CalculatorScreen.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/19/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

class CalculatorScreen {
    
    var app: XCUIApplication!
    let operators = ["enter", "multiply", "divide", "add", "subtract", "squareRoot", "sine", "cosine", "pi","clear"]
    let displays = ["calcDisplay", "opsHistory"]
    let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
    
    init(testApp: XCUIApplication) {
        self.app = testApp
    }
    
    // Checks if everything is loaded in expected initial state
    func allLoaded() -> Bool {
        return self.digitsAllThere() && self.opsAllThere() && self.displaysAllThere() && self.displaysInitialized()
    }
    
    // Checks if displays are in initial "clear" state
    func displaysInitialized() -> Bool {
        var initProper = self.displayText("calcDisplay") == "0" ? true : false
        initProper = self.displayText("opsHistory") == "" ? true : false
        return initProper
    }
    
    // Checks if displays reflect an illegal number error
    func displaysIllegalNumberError() -> Bool {
        var illegalNumberError = self.displayText("calcDisplay") == "0.0" ? true : false
        illegalNumberError = self.displayText("opsHistory") == "Illegal number" ? true : false
        return illegalNumberError
    }
    
    // Returns the text of a display
    func displayText(display: String) -> String {
        return self.app.staticTexts[display].label
    }
    
    // Returns the double value of calcDisplay text
    func calcResult() -> Double {
        return (self.displayText("calcDisplay") as NSString).doubleValue
    }
    
    // Enters a series of digits
    func enterDigits(digits: String) {
        let digitArray = Array(digits.characters)
        for digit in digitArray {
            self.app.buttons["\(digit)"].tap()
        }
        self.enterOperation("enter")
    }
    
    // Enters an operation
    func enterOperation(op: String) {
        self.app.buttons[op].tap()
    }
    
    // Enters 1 or more digits and the specified operator
    func enterCalculation(digits: Array<String>, op: String) {
        for digit in digits {
            self.enterDigits(digit)
        }
        self.enterOperation(op)
    }
    
    // private helper methods
    private func digitsAllThere() -> Bool {
        var allThere = false
        for digit in digits {
            allThere = self.app.buttons[digit].exists ? true : false
        }
        return allThere
    }
    
    private func opsAllThere() -> Bool {
        var allThere = false
        for op in operators {
            allThere = self.app.buttons[op].exists ? true : false
        }
        return allThere
    }
    
    private func displaysAllThere() -> Bool {
        var allThere = false
        for display in displays {
            allThere = self.app.staticTexts[display].exists ? true : false
        }
        return allThere
    }
}
