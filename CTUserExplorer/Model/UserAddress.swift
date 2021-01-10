//
//  UserAddress.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class UserAddress: Codable {
    enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        
        case coordinates = "geo"
    }
    
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    
    var coordinates: UserAddressGeo?
}

class UserAddressGeo: Codable {
    enum CodingKeys: String, CodingKey {
        case long = "lng"
        case lat = "lat"
    }
    var long: String?
    var lat: String?
}
