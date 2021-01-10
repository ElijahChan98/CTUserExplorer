//
//  UsersListViewModel.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UsersListViewModel {
    var delegate: UsersListViewModelDelegate?
    var users: [User] = []
    
    func fetchUsers() {
        RequestManager.shared.fetchUsers(since: 0, limit: 10) { (success, payload) in
            if success, let payloads = payload?["payloads"] as? [[String: Any]] {
                for payload in payloads {
                    if let user = User.createUserFromPayload(payload) {
                        self.users.append(user)
                    }
                }
            }
            self.delegate?.reloadTableView()
        }
    }
}
protocol UsersListViewModelDelegate {
    func reloadTableView()
}
