//
//  UsersListViewController.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController, UsersListViewModelDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    let viewModel = UsersListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Messages.USER_LIST
        viewModel.delegate = self
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        
        viewModel.fetchUsers()
    }
    
    func reloadTableView(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableview.isHidden = false
            tableview.reloadData()
            return
        }
        
        tableview.insertRows(at: newIndexPathsToReload, with: .automatic)
    }
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = viewModel.users[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.companyNameLabel.text = user.company?.companyName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        let viewModel = UserDetailsViewModel()
        viewModel.user = user
        let detailsView = UserDetailsViewController()
        detailsView.viewModel = viewModel
        
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.currentCount {
            viewModel.fetchUsers()
        }
    }
}
