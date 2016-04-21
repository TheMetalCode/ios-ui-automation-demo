//
//  RandomPhotoTests.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/21/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

class RandomPhotoTests: XCTestCase {
    
    let app = XCUIApplication()
    var randPhotoScreen : RandomPhotoScreen!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        randPhotoScreen = RandomPhotoScreen(testApp: app)
        randPhotoScreen.tabBar.navigateTo("Random Image")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSmoke() {
        waitForActivityIndicatorToFinishSpinning(randPhotoScreen.spinner, timeout: 45.0)
        XCTAssertTrue(randPhotoScreen.allLoaded(), "App appears to have not loaded properly")
    }
}
