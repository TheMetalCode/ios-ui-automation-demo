//
//  SplashbaseAPI.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/20/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import Foundation

enum SplashbasePhotoResult {
    case Success(Photo)
    case Failure(ErrorType)
}

enum SplashbaseError : ErrorType {
    case InvalidJSONData
}

struct SplashbaseAPI {
    
    static func randomImageURL() -> NSURL {
        let baseComponents = NSURLComponents(string: "http://www.splashbase.co/api/v1/images/random")!
        var queryItems = [NSURLQueryItem]()
        let baseParams = ["format" : "json"]
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        baseComponents.queryItems = queryItems
        return baseComponents.URL!
    }
    
    static func photoFromJSONData(data: NSData) -> SplashbasePhotoResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let jsonDictionary = jsonObject as? [NSObject : AnyObject],
                photoID = jsonDictionary["id"] as? Int,
                urlString = jsonDictionary["url"] as? String
            else {
                return .Failure(SplashbaseError.InvalidJSONData)
            }
            return .Success(Photo(photoID: "\(photoID)", URL: NSURL(string : urlString)!))
        } catch let error {
            return .Failure(error)
        }
    
    }
    
}
