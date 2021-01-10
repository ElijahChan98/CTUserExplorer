//
//  UsersListViewController.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RequestManager.shared.fetchUsers(since: 0, limit: 10) { (success, payload) in
            if success, let payloads = payload?["payloads"] as? [[String: Any]] {
                for payload in payloads {
                    let user = User.createUserFromPayload(payload)
                    print(user)
                }
            }
        }
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
