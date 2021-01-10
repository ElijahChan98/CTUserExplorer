//
//  User.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class User: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
        
    }
    
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: UserAddress?
    var phone: String?
    var website: String?
    var company: UserCompany?
    
    ///Decoder func for ItunesMedia
    static func createUserFromPayload(_ payload: [String: Any]) -> User? {
        let decoder = JSONDecoder()
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            do {
                let user = try decoder.decode(User.self, from: jsonData)
                return user
            } catch {
                print(error.localizedDescription)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
