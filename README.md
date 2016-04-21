# iOS XCTest UI Automation Demo

A complement to [my Mobile Dev+Test 2016 presentation](https://mobiledevtest.techwell.com/program/concurrent-sessions/scalable-and-collaborative-ios-ui-test-automation-swift) and a tangible demonstration of the basic concepts covered therein.

## Calculator Tab

This is most of the work for programming projects #1-3 in the Stanford iTunesU course ["Developing iOS 8 Apps with Swift"](https://itunes.apple.com/us/course/developing-ios-8-apps-swift/id961180099). It also is a good opportunity to demonstrate basic drag-and-drop UI elements that have accessibility ids added via the storyboard. And lastly, the benefit of well-factored test automation code is readily apparent, because there are lots of buttons. Yes, it needs some MVC loving (which it would get further on in the iTunesU course), and yes it needs some unit tests. But for our purposes, it works.

## Item Table

This is a table view where you may add, reorder, and delete cells. This is meant to demonstrate the ability to set accessibility IDs programmatically.

## Random Image

This is an image view that uses [Splashbase's API](http://www.splashbase.co/api#images_random) to pull down and display a random image. This is, as you might guess, highly asynchronous, and hence a good opportunity to demonstrate asynchonous test expectations.

## UI Tests Folder

This is where you'll find the XCTest cases as well as all the supporting code behind them (Screen Objects, extensions, protocols, etc).

## Usage

- Ensure you have XCode 7.0+
- Clone this repo
- Open in XCode, and give the tests a spin with Cmd + U.
- Explore and tinker to your hearts content.
