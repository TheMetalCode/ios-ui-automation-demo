//
//  Item.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/20/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import UIKit
class Item : NSObject, NSCoding {
    var name : String
    var dateCreated : NSDate
    let itemKey : String
    
    init(name: String) {
        self.name = name
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Huge", "Funny", "Disgusted"]
            var randIndex = arc4random_uniform(UInt32(adjectives.count))
            let randAdj = adjectives[Int(randIndex)]
            
            let nouns = ["Elephant", "Grizzly", "Owl"]
            randIndex = arc4random_uniform(UInt32(nouns.count))
            let randNoun = nouns[Int(randIndex)]
            
            let randName = "\(randAdj) \(randNoun)"
            self.init(name: randName)
        } else {
            self.init(name: "")
        }
    
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
    }
}
