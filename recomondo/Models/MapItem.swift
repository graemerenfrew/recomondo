//
//  MapItem.swift
//  recomondo
//
//  Created by Graeme Renfrew on 28/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//
import Foundation

struct MapItem{
    let mapItemId: String
    let isCurrentLocation: Bool
    let name: String
    let phoneNumber: String
    let placemark: String
    let timeZone: String
    let url: String
    
    init(mapItemId: String, dictionary: [String: Any]) {
        self.mapItemId = mapItemId
        self.isCurrentLocation = dictionary["isCurrentLocation"]  as? Bool ?? false
        self.name =  dictionary["name"] as? String ?? ""
        self.phoneNumber =  dictionary["phoneNumber"] as? String ?? ""
        self.placemark =  dictionary["placemark"] as? String ?? ""
        self.timeZone = dictionary["timeZone"]  as? String ?? ""
        self.url = dictionary["url"]  as? String ?? ""
     
    }
}

