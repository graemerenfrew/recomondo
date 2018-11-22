//
//  CustomImageView.swift
//  recomondo
//
//  Created by Graeme Renfrew on 22/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        print("loading image")
        lastURLUsedToLoadImage = urlString //track if we already loaded this
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
            
            //update the images on the main queue
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
}
