//
//  UserCompany.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UserCompany: Codable {
    enum CodingKeys: String, CodingKey {
        case companyName = "name"
        case companyPhrase = "catchPhrase"
        case companyDesc = "bs"
    }
    var companyName: String?
    var companyPhrase: String?
    var companyDesc: String?
}
