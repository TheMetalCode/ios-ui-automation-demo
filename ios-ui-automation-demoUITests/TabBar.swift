//
//  TabBar.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/21/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

class TabBar : Loadable {
    
    var app : XCUIApplication!
    var tabBar : XCUIElement!
    let tabs = ["calculator", "item-table", "random-photo"]
    
    init(testApp: XCUIApplication) {
        app = testApp
        tabBar = app.tabBars["tab-bar"]
    }
    
    func allLoaded() -> Bool {
        return tabBar.exists && allTabsExist()
    }
    
    private func allTabsExist() -> Bool {
        var allThere = false
        for tab in tabs {
            if !tabBar.tabs[tab].exists {
                allThere = false
                break
            }
        }
        return allThere
    }
}