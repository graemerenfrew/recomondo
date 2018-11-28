//
//  VenueLocation.swift
//  recomondo
//
//  Created by Graeme Renfrew on 28/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation

struct VenueLocation{
    let venue: Venue
    let address: String
    let crossStreet: String
    let city: String
    let state: String
    let postalCode: String
    let country: String
    let latitude: String
    let longitude: String
    let creationDate: Date
    
    init(venue: Venue, dictionary: [String: Any]) {
        self.venue = venue
        self.address =  dictionary["name"] as? String ?? ""
        self.crossStreet = dictionary["address"] as? String ?? ""
        self.city = dictionary["distance"] as? String ?? ""
        self.state = dictionary["latitude"] as? String ?? ""
        self.postalCode = dictionary["longitude"]  as? String ?? ""
        self.country = dictionary["longitude"]  as? String ?? ""
        self.latitude = dictionary["longitude"]  as? String ?? ""
        self.longitude = dictionary["longitude"]  as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970:   secondsFrom1970)    }
}
