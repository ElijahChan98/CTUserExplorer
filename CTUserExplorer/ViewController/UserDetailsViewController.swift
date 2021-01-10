//
//  UserDetailsViewController.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UserDetailsViewModelDelegate {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyCatchphraseLabel: UILabel!
    @IBOutlet weak var companyBsLabel: UILabel!
    
    var viewModel: UserDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewLoaded()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func reloadUIElements() {
        self.title = viewModel.user.name
        self.usernameLabel.text = "Username: \(viewModel.user.username!)"
        self.emailLabel.text = "Email: \(viewModel.user.email ?? "No Email")"
        self.addressLabel.text = viewModel.getFullAddress()
        self.phoneNumberLabel.text = "Phone Number: \(viewModel.user.phone ?? "No Phone")"
        self.websiteLabel.text = "Website: \(viewModel.user.website ?? "No Website")"
        self.companyNameLabel.text = "Company Name: \(viewModel.user.company?.companyName ?? "No Company")"
        self.companyCatchphraseLabel.text = viewModel.user.company?.companyPhrase
        self.companyBsLabel.text = viewModel.user.company?.companyDesc
    }

    @IBAction func onViewOnMapButtonClick(_ sender: Any) {
    }

}
