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
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03) //black with low alpha
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03) //black with low alpha
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03) //black with low alpha
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .blue
        button.backgroundColor = UIColor(displayP3Red: 149/255, green: 205/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        //now centre in x axis
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        
        setupInputFields()
    
    }
    
    fileprivate func setupInputFields() {
        //quick way to create multiple input fields
        
        //let greenView = UIView()
        //greenView.backgroundColor = .green
        //let redView = UIView()
        //redView.backgroundColor = .red
        //let blueView = UIView()
       //blueView.backgroundColor = .blue
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false //you need this to show the controls
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
                    stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
                    stackView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 40),
                    stackView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -40),
                    stackView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
    }

}

