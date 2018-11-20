//
//  MainTabBarController.swift
//  recomondo
//
//  Created by Graeme Renfrew on 20/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        
        // button.setImage(Image Literal, for: .normal) and then click the icon that Image Literal transforms into
        let profile_selected = UIImage(named: "profile_selected")
        let profile = UIImage(named: "profile")
        navController.tabBarItem.image = profile
        navController.tabBarItem.selectedImage = profile_selected
        
        
        viewControllers = [navController]
    }
    
}
