//
//  CalculatorViewController.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/19/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    var userIsInTheMiddleOfTypingANumber = false
    var operandStack = Array<Double>()
    var historyStack = Array<String>()
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack = Array<Double>()
        historyStack = Array<String>()
        displayValue = 0
        history.text = ""
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        // Do something here to make sure we have a legal float
        if (display.text!).rangeOfString("\\.\\d*\\.", options: NSStringCompareOptions.RegularExpressionSearch) != nil {
            clear()
            updateHistory("Illegal number")
        } else {
            operandStack.append(displayValue)
            updateHistory("\(operandStack.last!)")
        }
    }
    
    // Begin stuff that belongs in a model
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×":
                performOperation { $0 * $1 }
            case "÷":
                performOperation { $1 / $0 }
            case "+":
                performOperation { $0 + $1 }
            case "−":
                performOperation { $1 - $0 }
            case "√":
                performOperation { sqrt($0) }
            case "π":
                displayValue = M_PI; enter()
            case "sin":
                performOperation { sin($0) }
            case "cos":
                performOperation { cos($0) }
            default: break
        }
        updateHistory(operation + " \(operandStack.last!)")
    }
    
    func updateHistory(value: String) {
        if historyStack.count > 10 {
            historyStack.removeAtIndex(0)
        }
        historyStack.append(value)
        history.text = historyStack.last!
    }
    
    // Bullcrap alert: Swift 1.2 thinks two doubles and one double are the same method signature. Sad panda.
    // Workaround is to give one method an optional default param that we just won't actually use
    // http://stackoverflow.com/questions/28500486/swift-1-2-redeclares-objective-c-method
    func performOperation(r:String? = "2", operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    // End stuff that belongs in a model
}
