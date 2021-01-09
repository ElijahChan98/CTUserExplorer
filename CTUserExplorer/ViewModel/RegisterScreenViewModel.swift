//
//  RegisterScreenViewModel.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/9/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

class RegisterScreenViewModel {
    private var loadedCountries: [String] = []
    
    var countries: [String] {
        guard self.loadedCountries.count > 0 else{
            for code in NSLocale.isoCountryCodes as [String] {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                loadedCountries.append(name)
            }
            return self.loadedCountries
        }
        return self.loadedCountries
    }
    
    func registerUser(username: String, password: String, country: String, completion: @escaping (_ success: Bool, _ message: String) -> ()) {
        CTUserPersistence.shared.retrieve(username: username) { (success, ctUser) in
            if success {
                completion(false, Messages.ACCOUNT_EXISTS)
                return
            }
            else {
                let user = CTUser()
                user.username = username
                user.password = password
                user.countryOfOrigin = country
                
                CTUserPersistence.shared.save(ctUser: user)
                completion(true, Messages.REGISTER_SUCCESS)
                return
            }
        }
    }
}
