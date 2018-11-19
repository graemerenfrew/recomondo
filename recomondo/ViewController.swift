//
//  ViewController.swift
//  recomondo
//
//  Created by Graeme Renfrew on 19/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        // getting this image into code is a real ball-ache
        // button.setImage(Image Literal, for: .normal) and then click the icon that Image Literal transforms into
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false //some bug means you need this to show the controls
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        //now centre in x axis
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        view.addSubview(emailTextField)
        
    }


}

