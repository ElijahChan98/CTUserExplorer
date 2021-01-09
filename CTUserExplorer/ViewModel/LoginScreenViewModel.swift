//
//  LoginScreenViewModel.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/9/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class LoginScreenViewModel {
    func loginUser(username: String, password: String, completion: @escaping (_ success: Bool, _ message: String) -> ()) {
        CTUserPersistence.shared.validate(username: username, password: password) { (success) in
            if success {
                completion(success, Messages.LOGIN_SUCCESS)
            }
            else {
                completion(success, Messages.LOGIN_FAILED)
            }
        }
    }
}
