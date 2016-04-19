//
//  IosUIAutomationDemoUITests.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/19/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

class IosUIAutomationDemoUITests: XCTestCase {
        
    let app = XCUIApplication()
    var calcScreen : CalculatorScreen!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        calcScreen = CalculatorScreen(testApp: app)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Expect display and all buttons to be present when app loads
    func testSmoke() {
        XCTAssertTrue(calcScreen.allLoaded(), "App appears to have not loaded properly")
    }
    
    // The first digit entry clears the display and sets the display to the digit entered
    func testInitialCalcEntry() {
        calcScreen.enterDigits("9")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "9", "Calc display did not clear and reset properly")
    }
    
    // Subsequent entries are appended to the current display
    func testSubsequentCalcEntry() {
        calcScreen.enterDigits("98")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "98", "Calc display did not append properly")
    }
    
    // Enter key starts new entry
    func testEnterKey() {
        calcScreen.enterDigits("98")
        calcScreen.enterDigits("7")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "7", "Enter key did not start new entry")
    }
    
    // Multiplies two numbers
    func testMultiply() {
        calcScreen.enterCalculation(["4", "2"], op: "multiply")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "8.0", "Calculator does not correctly multiply")
    }
    
    // Divides first number by second number
    func testDivide() {
        calcScreen.enterCalculation(["4", "2"], op: "divide")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "2.0", "Calculator does not correctly multiply")
    }
    
    // Adds two numbers
    func testAdd() {
        calcScreen.enterCalculation(["4", "2"], op: "add")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "6.0", "Calculator does not correctly multiply")
    }
    
    // Subtracts two numbers
    func testSubtract() {
        calcScreen.enterCalculation(["4", "2"], op: "subtract")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "2.0", "Calculator does not correctly multiply")
    }
    
    // Multiplies two numbers, then adds a number, then subtracts a number, then divides by a number
    func testCompoundBasicOps() {
        calcScreen.enterCalculation(["4", "2"], op: "multiply")
        calcScreen.enterCalculation(["5"], op: "add")
        calcScreen.enterCalculation(["8"], op: "subtract")
        calcScreen.enterCalculation(["4"], op: "divide")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "1.25", "Calculator does not correctly perform compound operations")
    }
    
    // Square root of one number
    func testSquareRoot() {
        calcScreen.enterCalculation(["9"], op: "squareRoot")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "3.0", "Calculator does not correctly calculate square root")
    }
    
    // Sine of one number
    func testSine() {
        calcScreen.enterCalculation(["9"], op: "sine")
        XCTAssertEqualWithAccuracy(calcScreen.calcResult(), sin(9.0), accuracy: 0.00000000000001, "Calculator does not correctly calculate sine")
    }
    
    // Cosine of one number
    func testCosine() {
        calcScreen.enterCalculation(["9"], op: "cosine")
        XCTAssertEqualWithAccuracy(calcScreen.calcResult(), cos(9.0), accuracy: 0.00000000000001, "Calculator does not correctly calculate cosine")
    }
    
    // Pi as an operand
    func testPi() {
        calcScreen.enterCalculation(["3"], op: "pi")
        calcScreen.enterOperation("multiply")
        XCTAssertEqualWithAccuracy(calcScreen.calcResult(), 3 * M_PI, accuracy: 0.0000000000001, "Calculator does not correctly use Pi as operand")
    }
    
    // ops history always shows last operand or operator entered
    func testOpsHistory() {
        calcScreen.enterDigits("4")
        XCTAssertEqual(calcScreen.displayText("opsHistory"), "4.0", "ops history did not correctly update")
        calcScreen.enterCalculation(["2"], op: "subtract")
        XCTAssertEqual(calcScreen.displayText("opsHistory"), "− 2.0", "ops history did not correctly update")
    }
    
    // C button clears operandStack, historyStack, displays, etc.
    func testClear() {
        // do some stuff first
        calcScreen.enterCalculation(["4", "2"], op: "multiply")
        calcScreen.enterCalculation(["5"], op: "add")
        //now nuke it all
        calcScreen.enterOperation("clear")
        XCTAssertTrue(calcScreen.displaysInitialized(), "Clear button did not clear calc display and ops history")
    }
    
    // Does legal float inputs
    func testLegalFloatInputs() {
        calcScreen.enterCalculation(["4.25", ".5"], op: "multiply")
        XCTAssertEqual(calcScreen.displayText("calcDisplay"), "\(4.25 * 0.5)", "Did not properly calculate float inputs")
    }
    
    // Starts over if you try to input an illegal number
    func testIllegalFloatInput() {
        calcScreen.enterDigits("4.25")
        calcScreen.enterDigits("7.8.9")
        XCTAssertTrue(calcScreen.displaysIllegalNumberError(), "Displays do not reflect an illegal number error as expected")
    }
}
