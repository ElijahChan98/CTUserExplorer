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
        viewModel.delegate = self
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        
        viewModel.fetchUsers()
    }

    func reloadTableView() {
        self.tableview.reloadData()
    }
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = viewModel.users[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.companyNameLabel.text = user.company?.companyName
        
        return cell
    }
    
    
}
