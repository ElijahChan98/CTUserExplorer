//
//  UserDetailsViewModel.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UserDetailsViewModel {
    var delegate: UserDetailsViewModelDelegate?
    var user: User!
    
    func viewLoaded(){
        self.delegate?.reloadUIElements()
    }
    
    func getFullAddress() -> String {
        guard let address = user.address else {
            return "No Address"
        }
        let fullAddress = [address.suite ?? "", address.street ?? "", address.city ?? "", address.zipcode ?? ""]
        return fullAddress.joined(separator: " ")
    }
}

protocol UserDetailsViewModelDelegate {
    func reloadUIElements()
}
