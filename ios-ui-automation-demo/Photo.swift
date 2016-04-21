//
//  Photo.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/20/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import UIKit
class Photo {
    let URL : NSURL
    let photoID : String
    var image : UIImage?
    
    init(photoID: String, URL: NSURL) {
        self.photoID = photoID
        self.URL = URL
    }
}
