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
    
    func setupViewControllers() {
        //home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Home"), selectedImage: #imageLiteral(resourceName: "Home_Selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))  //optional to show the Profile view on the Home, until we've built a nice home view
        
        //search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Search"), selectedImage: #imageLiteral(resourceName: "Search_Selected"))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Photo"), selectedImage: #imageLiteral(resourceName: "Photo"))
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Activity"), selectedImage: #imageLiteral(resourceName: "Activity_Selected"))
        
        //user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "Profile")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Profile_Selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           plusNavController,
                           likeNavController,
                           userProfileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
