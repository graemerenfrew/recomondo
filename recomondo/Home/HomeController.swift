//
//  HomeController.swift
//  recomondo
//
//  Created by Graeme Renfrew on 22/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //watch for notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name:  SharePhotoController.updateFeedNotificationName, object: nil)
        
        collectionView?.backgroundColor  = .white        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        setupNavigationItems()
        fetchAllPosts()
     
       
    }
    
    @objc func handleUpdateFeed() {
        print("handle update feed")
        handleRefresh()
    }
    
    @objc func handleRefresh() {
        print("refres...")
        posts.removeAll() //clear out the collection if I unfollow someone
        fetchAllPosts()
    }
    
    fileprivate func fetchAllPosts() {
        fetchOrderedPosts()
        fetchFollowingUserIds()
    }
    fileprivate func fetchFollowingUserIds() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            //print(snapshot.value)
            guard let userIdsDictionary = snapshot.value as? [String: Any] else {return}
            userIdsDictionary.forEach({ (key, value) in
                Database.fetchUserWithUID(uid: key, completion: { (user) in
                    self.fetchPostsWithUser(user: user)
                })
            })
        }) { (err) in
            print("failed to retreive following posts", err)
        }
        
    }
    
    var posts = [Post]()
    
    fileprivate func fetchOrderedPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPostsWithUser(user: user)
        }
        
    }
    
    fileprivate func fetchPostsWithUser(user: User) {
        let ref = Database.database().reference().child("posts").child(user.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            self.collectionView?.refreshControl?.endRefreshing()
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String:Any] else {return}
                let post = Post(user: user, dictionary: dictionary)
                self.posts.append(post)
            })
            
            self.posts.sort(by: { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            
            self.collectionView?.reloadData()
        }) { (err) in
            print("failed", err)
        }

    }
    
    fileprivate func fetchPostsWithUserOld(user: User) {
        //guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let post = Post(user: user, dictionary: dictionary)
            //let post = Post(dummyUser: User, dictionary: dictionary)
            self.posts.insert(post, at: 0)
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch  posts for the home view:", err)
        }
    }
    func setupNavigationItems()
    {
        navigationItem.titleView = UIImageView(image:  #imageLiteral(resourceName: "Logo_Recomondo"))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
    }
    
    @objc func handleCamera() {
        print("running camera")
        let cameraController = CameraController()
        present(cameraController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 //username and user profile image view
        height += view.frame.width
        height += 50 //bottom row of buttuns
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           //how to render items on to the collection view?
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        //bug fix
        if indexPath.item < posts.count {
            cell.post = posts[indexPath.item]
        }
        return cell
    }
}
