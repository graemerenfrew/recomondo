//
//  CheckInCell.swift
//  recomondo
//
//  Created by Graeme Renfrew on 23/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import UIKit

class VenueSearchCell: UICollectionViewCell {
    
    //optional, because this first starts as nil
    var venue: Venue? {
        didSet {
            venueNameLabel.text = venue?.name
            //guard let profileImageUrl = user?.profileImageUrl else {return}
            //profileImageView.loadImage(urlString:profileImageUrl)
        }
    }
    
    let venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return separatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        //addSubview(profileImageView)
        addSubview(venueNameLabel)
        addSubview(separatorView)
        
       // profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        //center it
        //profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //profileImageView.layer.cornerRadius = 50 / 2
        
       // venueNameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //we should put a picture of the venue type in the profileImageView object
        
        venueNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        separatorView.anchor(top: nil, left: venueNameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
