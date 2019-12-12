//
//  ChatsTableViewController.swift
//  FirebaseChat
//
//  Created by Chad Rutherford on 12/10/19.
//  Copyright © 2019 chadarutherford.com. All rights reserved.
//

import Firebase
import UIKit
import SwiftUI

class ChatsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if Auth.auth().currentUser == nil {
//            perform(#selector(handleLogout), with: nil, afterDelay: 0)
//        }
    }
    
    @objc func handleLogout() {
        try? Auth.auth().signOut()
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true)
    }
}


struct ChatsPreview: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: ChatsPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChatsPreview.ContainerView>) {
                
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChatsPreview.ContainerView>) -> UIViewController {
            return UINavigationController(rootViewController: ChatsTableViewController())
        }
    }
}
