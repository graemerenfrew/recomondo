//
//  Visit.swift
//  recomondo
//
//  Created by Graeme Renfrew on 28/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//
// Track the details of a users visit to a location
import Foundation

struct Visit {
    let venue: Venue
    //let locationType: String
    let caption: String
    let creationDate: Date
    
    init(venue: Venue, dictionary: [String: Any]) {
        self.venue = venue
       // self.locationType = dictionary["locationType"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970:   secondsFrom1970)
    }

}
    /*

arrivalDate
arrivalLocation
departureDate
departureLocation
hasDeparted
locationType
confidence
confidenceString
+confidenceStringForValue:
venue
otherPossibleVenues
nearbyVenues
displayName
pilgrimVisitId
-init
*/
