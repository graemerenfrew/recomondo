//
//  VisitVenueController.metal
//  recomondo
//
//  Created by Graeme Renfrew on 28/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import Foundation

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
       return
        
        guard let caption = textView.text, !caption.isEmpty else { return }
        /*
        guard let image = selectedImage else { return }
        
        guard let uploadData = image.jpegData(compressionQuality: 0.2) else { return }
        
        
        //disable share from being pressed multiple times
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(filename)
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
    
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
       
        containerView.addSubview(venueView)
        venueView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
       /*
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
 */
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
