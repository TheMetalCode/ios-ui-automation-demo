//
//  ItemTableTests.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/21/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

class ItemTableTests: XCTestCase {
    
    let app = XCUIApplication()
    var itemTableScreen : ItemTableScreen!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        itemTableScreen = ItemTableScreen(testApp: app)
        itemTableScreen.tabBar.navigateTo("Item Table")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Expect display and all buttons to be present when app loads
    func testSmoke() {
        XCTAssertTrue(itemTableScreen.allLoaded(), "App appears to have not loaded properly")
    }
    
    func testAddItem () {
    
    }
    
    func testDeleteItem() {
    
    }
}
