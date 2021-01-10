//
//  LoginScreenViewController.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/9/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = LoginScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButtonClick(_ sender: Any) {
        guard usernameTextField.text != "", passwordTextField.text != "" else {
            CTUserExplorerUtils.showGenericOkAlert(title: nil, message: Messages.FILL_UP_REQUIRED_FIELDS) 
            return
        }
        viewModel.loginUser(username: usernameTextField.text!, password: passwordTextField.text!) { (success, message) in
            CTUserExplorerUtils.showGenericOkAlert(title: nil, message: message, handler: { (action) in
                if success {
                    let navController = UINavigationController(rootViewController: UsersListViewController())
                    (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(navController)
                }
            })
        }
    }
    
    @IBAction func onRegisterButtonClick(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterScreenViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
