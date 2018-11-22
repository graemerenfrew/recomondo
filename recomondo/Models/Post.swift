//
//  Post.swift
//  recomondo
//
//  Created by Graeme Renfrew on 22/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
    
}
