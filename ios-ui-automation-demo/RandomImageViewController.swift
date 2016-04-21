//
//  RandomImageViewController.swift
//  ios-ui-automation-demo
//
//  Created by Jason Hagglund on 4/20/16.
//  Copyright © 2016 Jason Hagglund. All rights reserved.
//

import UIKit
class RandomImageViewController : UIViewController {
    
    var photoStore : PhotoStore!
    var photo : Photo!
    var image : UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        fetchImage()
    }
    
    private func fetchImage() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.center = self.view.center
        spinner.startAnimating()
        self.view.addSubview(spinner)
        photoStore.fetchRandomPhoto() { (photoResult) -> Void in
            switch photoResult {
            case let .Success(photo):
                self.photo = photo
                self.photoStore.fetchImageForPhoto(photo) { (imageResult) -> Void in
                    switch imageResult {
                    case let .Success(image):
                        self.image = image
                        self.imageView.image = image
                        spinner.stopAnimating()
                    case let .Failure(error):
                        print("Unable to load image: \(error)")
                    }
                }
            case let .Failure(error):
                print("Unable to fetch photo: \(error)")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.photoStore = PhotoStore()
    }
}