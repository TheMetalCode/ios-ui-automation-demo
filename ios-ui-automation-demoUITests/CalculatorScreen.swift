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
    
    var app : XCUIApplication!
    var tabBar : TabBar!
    let operators = ["enter", "multiply", "divide", "add", "subtract", "squareRoot", "sine", "cosine", "pi","clear"]
    let displays = ["calcDisplay", "opsHistory"]
    let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
    
    init(testApp: XCUIApplication) {
        app = testApp
        tabBar = TabBar(testApp: app)
    }
    
    // Checks if everything is loaded in expected initial state
    func allLoaded() -> Bool {
        
        return tabBar.allLoaded() && digitsAllThere()
            && opsAllThere() && displaysAllThere()
            && displaysInitialized()
    }
    
    private func digitsAllThere() -> Bool {
        var allThere = false
        for digit in digits {
            if app.buttons[digit].exists {
                allThere = true
            } else {
                allThere = false
                break
            }
        }
        return allThere
    }
    
    private func opsAllThere() -> Bool {
        var allThere = false
        for op in operators {
            if app.buttons[op].exists {
                allThere = true
            } else {
                allThere = false
                break
            }
        }
        return allThere
    }
    
    private func displaysAllThere() -> Bool {
        var allThere = false
        for display in displays {
            if app.staticTexts[display].exists {
                allThere = true
            } else {
                allThere = false
                break
            }
        }
        return allThere
    }
    
    // Checks if displays are in initial "clear" state
    func displaysInitialized() -> Bool {
        var initProper = displayText("calcDisplay") == "0" ? true : false
        initProper = displayText("opsHistory") == "" ? true : false
        return initProper
    }
    
    // Checks if displays reflect an illegal number error
    func displaysIllegalNumberError() -> Bool {
        var illegalNumberError = displayText("calcDisplay") == "0.0" ? true : false
        illegalNumberError = displayText("opsHistory") == "Illegal number" ? true : false
        return illegalNumberError
    }
    
    // Returns the text of a display
    func displayText(display: String) -> String {
        return app.staticTexts[display].label
    }
    
    // Returns the double value of calcDisplay text
    func calcResult() -> Double {
        return (displayText("calcDisplay") as NSString).doubleValue
    }
    
    // Enters a series of digits
    func enterDigits(digits: String) {
        let digitArray = Array(digits.characters)
        for digit in digitArray {
            app.buttons["\(digit)"].tap()
        }
        enterOperation("enter")
    }
    
    // Enters an operation
    func enterOperation(op: String) {
        app.buttons[op].tap()
    }
    
    // Enters 1 or more digits and the specified operator
    func enterCalculation(digits: Array<String>, op: String) {
        for digit in digits {
            enterDigits(digit)
        }
        enterOperation(op)
    }
    
    // Enters each calculation: accepts an array of size 2-3 arrays where the last element must be a string representing an operation
    func enterCalculations(calculations: Array<Array<String>>) {
        for calculation in calculations {
            if calculation.count == 3 {
                enterCalculation([calculation[0], calculation[1]], op: calculation [2])
            } else if calculation.count == 2 {
                enterCalculation([calculation[0]], op: calculation[1])
            } else {
                print("Cannot currently handle ops of this size so your test is about to time out, sorry!")
            }
            
        }
    }
}
