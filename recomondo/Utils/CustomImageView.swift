//
//  CustomImageView.swift
//  recomondo
//
//  Created by Graeme Renfrew on 22/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString //track if we already loaded this
        
        //avoid the flickering
        self.image = nil
        
        //check if we already cached this particular image before
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return //leave this function and don't do all the below image fetching network traffic
        }
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("failedto fetch post image: ", err)
                return
            }
            
            //ensure we only reload the cells onetime
            if url.absoluteString != self.lastURLUsedToLoadImage{ return }
            
            guard let imageData = data else {return}
            
            let photoImage = UIImage(data: imageData)
            //put the image in the cache
            imageCache[url.absoluteString] = photoImage
            
            //update the images on the main queue
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
}
