//
//  ItemCell.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/20/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import UIKit
class ItemCell : UITableViewCell {
    
    @IBOutlet var nameLabel : UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
    }
}
