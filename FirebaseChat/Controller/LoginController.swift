//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Chad Rutherford on 12/10/19.
//  Copyright © 2019 chadarutherford.com. All rights reserved.
//

import UIKit
import SwiftUI

class LoginController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let inputsContainerView: UIView = {
        let inputsView = UIView()
        inputsView.translatesAutoresizingMaskIntoConstraints = false
        inputsView.layer.cornerRadius = 5
        inputsView.layer.masksToBounds = true
        inputsView.backgroundColor = .white
        return inputsView
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name:"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let nameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address:"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password:"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        setupInputsContainerView()
        setupRegisterButton()
    }
    
    private func setupRegisterButton() {
        view.addSubview(loginRegisterButton)
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupInputsContainerView() {
        view.addSubview(inputsContainerView)
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3).isActive = true
        
        inputsContainerView.addSubview(nameSeparator)
        nameSeparator.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3).isActive = true
        
        inputsContainerView.addSubview(emailSeparator)
        emailSeparator.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3).isActive = true
    }
}

struct LoginPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: LoginPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginPreview.ContainerView>) {
            
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginPreview.ContainerView>) -> UIViewController {
            return LoginController()
        }
    }
}
