//
//  UserSearchCell.swift
//  recomondo
//
//  Created by Graeme Renfrew on 22/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//
import UIKit
import Foundation

class UserSearchCell: UICollectionViewCell {
    
    //optional, because this first starts as nil
    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            guard let profileImageUrl = user?.profileImageUrl else {return}
            profileImageView.loadImage(urlString:profileImageUrl)
        }
    }
    
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        //iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
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
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(separatorView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        //center it
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 50 / 2
        
        usernameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
       separatorView.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
