//
//  RandomPhotoScreen.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/21/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
import XCTest

class RandomPhotoScreen : Loadable {
    
    var app : XCUIApplication!
    var tabBar : TabBar!
    var spinner : XCUIElement!
    var image : XCUIElement!
    
    init(testApp: XCUIApplication) {
        app = testApp
        tabBar = TabBar(testApp: app)
        spinner = app.activityIndicators["random-photo-loading"]
        image = app.images["random-photo-loaded"]
    }
    
    func allLoaded() -> Bool {
        return tabBar.allLoaded() && image.exists && !spinner.exists
    }
}
