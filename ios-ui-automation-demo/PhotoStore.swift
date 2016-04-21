//
//  PhotoStore.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/20/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import UIKit
class PhotoStore {
    
    enum ImageResult {
        case Success(UIImage)
        case Failure(ErrorType)
    }
    
    enum PhotoError : ErrorType {
        case ImageCreationError
    }
    
    let session : NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRandomPhoto(completion completion: (SplashbasePhotoResult) -> Void) {
        let url = SplashbaseAPI.randomImageURL()
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processRandomPhotoRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processRandomPhotoRequest(data data: NSData?, error: NSError?) -> SplashbasePhotoResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return SplashbaseAPI.photoFromJSONData(jsonData)
    }
    
    func processImageRequest(data data: NSData?, error: NSError?) -> ImageResult {
        guard let imageData = data, image = UIImage(data: imageData) else {
            if data == nil {
                return .Failure(error!)
            } else {
                return .Failure(PhotoError.ImageCreationError)
            }
        }
        return .Success(image)
    }
    
    func fetchImageForPhoto(photo: Photo, completion: (ImageResult) -> Void) {
        let URL = photo.URL
        let request = NSURLRequest(URL: URL)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            if case let .Success(image) = result {
                photo.image = image
            }
            completion(result)
        }
        task.resume()
    }
}
