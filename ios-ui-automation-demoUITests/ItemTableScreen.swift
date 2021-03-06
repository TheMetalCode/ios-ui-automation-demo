//
//  ItemTableScreen.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/21/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

class ItemTableScreen : Loadable {
    
    var app : XCUIApplication!
    var tabBar : TabBar!
    var addButton : XCUIElement!
    var editButton : XCUIElement!
    var itemsTable : XCUIElement!
    
    init(testApp: XCUIApplication) {
        app = testApp
        tabBar = TabBar(testApp: app)
        addButton = app.buttons["add-button"]
        editButton = app.buttons["edit-button"]
        itemsTable = app.tables["items-table"]
    }
    
    func allLoaded() -> Bool {
        return tabBar.allLoaded()
    }
}