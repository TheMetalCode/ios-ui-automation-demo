//
//  ItemStore.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/20/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation
class ItemStore {
    
    var allItems = [Item]()
    
    let itemArchiveURL : NSURL = {
        let docDirs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docDir = docDirs.first!
        return docDir.URLByAppendingPathComponent("items.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as? [Item] {
            allItems += archivedItems
        }
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path!)
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.removeAtIndex(fromIndex)
        allItems.insert(movedItem, atIndex: toIndex)
    }
}