//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Chad Rutherford on 12/10/19.
//  Copyright © 2019 chadarutherford.com. All rights reserved.
//

import CodableFirebase
import Firebase
import UIKit
import SwiftUI

enum LoginType {
    case register
    case login
}

class LoginController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var loginType: LoginType = .register
    
    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "gameofthrones_splash")
        return iv
    }()
    let loginTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Register", "Login"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(r: 61, g: 91, b: 151)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentedControlChanged(_:)), for: .valueChanged)
        return sc
    }()
    let inputsContainerView: UIView = {
        let inputsView = UIView()
        inputsView.translatesAutoresizingMaskIntoConstraints = false
        inputsView.layer.cornerRadius = 5
        inputsView.layer.masksToBounds = true
        inputsView.backgroundColor = .white
        return inputsView
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name:"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .default
        tf.autocapitalizationType = .words
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
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
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
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        return tf
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
        button.addTarget(self, action: #selector(handleRegisterLogin(_:)), for: .touchUpInside)
        return button
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.hidesWhenStopped = true
        aiv.style = .large
        aiv.color = .darkGray
        return aiv
    }()
    var inputsContainerHeightConstraint: NSLayoutConstraint?
    var nameTextFieldHeightConstraint: NSLayoutConstraint?
    var emailTextFieldHeightConstraint: NSLayoutConstraint?
    var passwordTextFieldHeightConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        setupInputsContainerView()
        setupControl()
        setupRegisterButton()
        setupImageView()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    private func setupImageView() {
        view.addSubview(avatarImageView)
        avatarImageView.bottomAnchor.constraint(equalTo: loginTypeSegmentedControl.topAnchor, constant: -10).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupControl() {
        view.addSubview(loginTypeSegmentedControl)
        loginTypeSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -10).isActive = true
        loginTypeSegmentedControl.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        loginTypeSegmentedControl.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor).isActive = true
        loginTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
        inputsContainerHeightConstraint = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerHeightConstraint?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3)
        nameTextFieldHeightConstraint?.isActive = true
        inputsContainerView.addSubview(nameSeparator)
        nameSeparator.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightConstraint =  emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3)
        emailTextFieldHeightConstraint?.isActive = true
        
        inputsContainerView.addSubview(emailSeparator)
        emailSeparator.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightConstraint =  passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3)
        passwordTextFieldHeightConstraint?.isActive = true
    }
    
    @objc private func handleRegisterLogin(_ sender: UIButton) {
        activityIndicator.startAnimating()
        switch loginType {
        case .register:
            registerUser { user, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.showAlert(message: error.localizedDescription)
                    }
                }
                
                guard let user = user else { return }
                self.loginUser(with: user.email, password: user.password) { error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.showAlert(message: error.localizedDescription)
                            self.activityIndicator.removeFromSuperview()
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        case .login:
            guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
            loginUser(with: email, password: password) { error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.showAlert(message: error.localizedDescription)
                        self.activityIndicator.removeFromSuperview()
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    private func registerUser(completion: @escaping (UserModel?, Error?) -> ()) {
        guard let name = nameTextField.text, !name.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        let ref = Database.database().reference().root
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            let loginUser = UserModel(name: name, email: email, password: password)
            if let uid = user?.user.uid {
                let userToSave = ["name" : name, "email" : email]
                ref.child("users").child(uid).setValue(userToSave)
                DispatchQueue.main.async {
                    completion(loginUser, nil)
                    self.loginUser(with: email, password: password) { error in
                        if let error = error {
                            completion(nil, error)
                            return
                        }
                    }
                }
            }
        }
    }
    
    private func loginUser(with email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
                return
            }
            
            DispatchQueue.main.async {
                completion(nil)
                self.dismiss(animated: true)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func handleSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loginType = .register
            loginRegisterButton.setTitle("Register", for: .normal)
            inputsContainerHeightConstraint?.constant = 150
            nameTextFieldHeightConstraint?.isActive = false
            emailTextFieldHeightConstraint?.isActive = false
            passwordTextFieldHeightConstraint?.isActive = false
            nameTextFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3)
            emailTextFieldHeightConstraint =  emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3)
            passwordTextFieldHeightConstraint =  passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 3)
            nameTextFieldHeightConstraint?.isActive = true
            emailTextFieldHeightConstraint?.isActive = true
            passwordTextFieldHeightConstraint?.isActive = true
        case 1:
            loginType = .login
            loginRegisterButton.setTitle("Login", for: .normal)
            inputsContainerHeightConstraint?.constant = 100
            nameTextFieldHeightConstraint?.isActive = false
            emailTextFieldHeightConstraint?.isActive = false
            passwordTextFieldHeightConstraint?.isActive = false
            nameTextFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 2)
            passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1 / 2)
            nameTextFieldHeightConstraint?.isActive = true
            emailTextFieldHeightConstraint?.isActive = true
            passwordTextFieldHeightConstraint?.isActive = true
        default:
            break
        }
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
