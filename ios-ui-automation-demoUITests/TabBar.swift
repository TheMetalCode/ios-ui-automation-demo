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
    let tabs = ["Calculator", "Item Table", "Random Image"]
    
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
            if tabBar.buttons[tab].exists {
                allThere = true
            } else {
                allThere = false
                break
            }
        }
        return allThere
    }
    
    func navigateTo(tab: String) {
        tabBar.buttons[tab].tap()
    }
}