//
//  MainTabBarController.swift
//  recomondo
//
//  Created by Graeme Renfrew on 20/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check we have a logged in user
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async { //wait until the tabbar controller has been instantiated before running logic
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        setupViewControllers()
      
        
    }
    
    func setupViewControllers()
    {
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "Profile")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Profile_Selected")
        
        viewControllers = [navController, UIViewController()]
    }
}
