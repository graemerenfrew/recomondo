//
//  PhotoSelectorCell.swift
//  recomondo
//
//  Created by Graeme Renfrew on 21/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//
import UIKit
import Foundation

class PhotoSelectorHeader: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .cyan
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        //self.backgroundColor = .brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
