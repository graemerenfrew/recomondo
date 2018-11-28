//
//  Venue.swift
//  recomondo
//
//  Created by Graeme Renfrew on 28/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation

struct Venue{
    let locationid: String
    let name: String
    let latitude: String
    let longitude: String
    let isCurrentLocation: Bool
    
    init(locationid: String, dictionary: [String: Any]) {
        self.locationid = locationid
        self.name =  dictionary["name"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? String ?? ""
        self.longitude = dictionary["longitude"]  as? String ?? ""
        self.isCurrentLocation = dictionary["isCurrentLocation"]  as? Bool ?? false
    }
}
