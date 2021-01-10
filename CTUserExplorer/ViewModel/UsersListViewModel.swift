//
//  UsersListViewModel.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UsersListViewModel {
    var isFetchInProgress = false
    let fetchLimit = 10
    var currentSince = 0
    var currentCount: Int {
        return users.count
    }
    
    var delegate: UsersListViewModelDelegate?
    var users: [User] = []
    
    func fetchUsers() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        RequestManager.shared.fetchUsers(since: currentSince, limit: fetchLimit) { (success, payload) in
            if success, let payloads = payload?["payloads"] as? [[String: Any]] {
                var newUsersCount = 0
                for payload in payloads {
                    if let user = User.createUserFromPayload(payload) {
                        self.users.append(user)
                        newUsersCount += 1
                    }
                }
                
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    
                    if self.currentSince > 0 {
                        let indexPathToReload = self.calculateIndexPathsToReload(from: newUsersCount)
                        self.delegate?.reloadTableView(with: indexPathToReload)
                    }
                    else {
                        self.delegate?.reloadTableView(with: .none)
                    }
                    self.currentSince += self.fetchLimit
                }
            }
            else {
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newUsersCount: Int) -> [IndexPath] {
        let startIndex = users.count - newUsersCount
        let endIndex = startIndex + newUsersCount
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
protocol UsersListViewModelDelegate {
    func reloadTableView(with newIndexPathsToReload: [IndexPath]?)
}
