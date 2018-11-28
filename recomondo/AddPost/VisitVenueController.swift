//
//  VisitVenueController.metal
//  recomondo
//
//  Created by Graeme Renfrew on 28/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class VisitVenueController: UIViewController  {
    
    var selectedVenue: Venue? {
        didSet {  //gets called every time this var is set
            
            self.venueView.text = selectedVenue!.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded VisitVenueController")
        view.backgroundColor = UIColor.green
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        //basic photo and caption
        setupImageAndTextViews()
        
    }
    
    let venueView: UITextView = {
        let tv = UITextView()
        tv.text = "text here"
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    
    @objc func handleShare(){
        //don't let the caption be empty - basic check!
       //return
        
        guard let caption = textView.text, !caption.isEmpty else { return }
        guard let venue = selectedVenue else { return }
        
       // guard let uploadData = image.jpegData(compressionQuality: 0.2) else { return }
        
        
        //disable share from being pressed multiple times
        navigationItem.rightBarButtonItem?.isEnabled = false
    
        let visit = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("visits").child(visit)

        //check if the selected venue already exists in the local database
        
        self.saveToDatabase()
         /*
        storageRef.putData(uploadData, metadata: nil) { (metaData, err) in
            if let err = err {
                print("failed to upload image", err)
            }
            
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to fetch downloadURL:", err)
                    return
                }
                guard let imageUrl = downloadURL?.absoluteString else { return }
                
                print("Successfully uploaded post image:", imageUrl)
                
                self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
            })
        }
 */
    }
    
    fileprivate func saveToDatabase(){
        guard let postVenue = selectedVenue else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let caption = textView.text else { return }
        
        //get a reference from Firebase
        let userVisitRef = Database.database().reference().child("visits").child(uid)
        let ref =  userVisitRef.childByAutoId()
        
        //let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any] //need to cast this dictoray to string:any so it can all be in the one object
        
        let values = ["venueName": selectedVenue?.name, "caption": caption,"creationDate": Date().timeIntervalSince1970] as [String : Any] //need to cast this dictoray to string:any so it can all be in the one object
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("failed to save to DB", err)
                return
            }
            print("successfully saved post to db")
            self.dismiss(animated: true, completion: nil)
            
            //this posts a notification to the entire system
            
            //NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
        }
        
        
    }
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
       
        containerView.addSubview(venueView)
        venueView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
      
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: venueView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
