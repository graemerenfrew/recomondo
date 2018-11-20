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
       
        navController.tabBarItem.image = #imageLiteral(resourceName: "Profile")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Profile_Selected")
        
        viewControllers = [navController, UIViewController()]
    }
    
}
