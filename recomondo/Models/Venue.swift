//
//  Venue.swift
//  recomondo
//
//  Created by Graeme Renfrew on 28/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation

struct Venue{
    let venueId: String
    let name: String
    let probability: String
    let categories: String
    let hierarchy: String
    let creationDate: Date
    
    init(venueId: String, dictionary: [String: Any]) {
        self.venueId = venueId
        self.name =  dictionary["name"] as? String ?? ""
        self.probability =  dictionary["name"] as? String ?? ""
        self.categories =  dictionary["name"] as? String ?? ""
        self.hierarchy =  dictionary["name"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970:   secondsFrom1970)
    }
}
