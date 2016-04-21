//
//  UITestExtensions.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/21/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func waitForActivityIndicatorToFinishSpinning(activityIndicatorElement: XCUIElement, timeout: NSTimeInterval = 30.0) {
        let inProgressPredicate = NSPredicate(format: "exists == true")
        self.expectationForPredicate(inProgressPredicate, evaluatedWithObject: activityIndicatorElement, handler: nil)
        self.waitForExpectationsWithTimeout(timeout, handler: nil)
        
        let progressHaltedPredicate = NSPredicate(format: "exists == false")
        self.expectationForPredicate(progressHaltedPredicate, evaluatedWithObject: activityIndicatorElement, handler: nil)
        self.waitForExpectationsWithTimeout(timeout, handler: nil)
    }
}
