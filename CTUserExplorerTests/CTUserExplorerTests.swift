//
//  CTUserExplorerTests.swift
//  CTUserExplorerTests
//
//  Created by Elijah Tristan Huey Chan on 1/9/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import XCTest
@testable import CTUserExplorer

class CTUserExplorerTests: XCTestCase {
    func testCalculateIndexPathsToReload() {
        let viewModel = UsersListViewModel()
        let sampleUsers: [User] = [User(), User(), User()]
        viewModel.users = sampleUsers
        
        let pathsToReload = viewModel.calculateIndexPathsToReload(from: 2)
        let expectedResult = [IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)]
        XCTAssert(pathsToReload == expectedResult)
    }
    
    func testGetFullAddress() {
        let user = User()
        let address = UserAddress()
        address.suite = "Suite"
        address.street = "Street"
        address.city = "City"
        address.zipcode = "1010"
        user.address = address
        
        let viewModel = UserDetailsViewModel()
        viewModel.user = user
        
        let expectedResult = "Suite Street City 1010"
        XCTAssert(viewModel.getFullAddress() == expectedResult)
        
        viewModel.user.address = nil
        XCTAssert(viewModel.getFullAddress() == "No Address")
    }
    
    let samplePayload: [String: Any] = [
          "id": 1,
          "name": "Leanne Graham",
          "username": "Bret",
          "email": "Sincere@april.biz",
          "address": [
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": [
              "lat": "-37.3159",
              "lng": "81.1496"
            ]
        ],
          "phone": "1-770-736-8031 x56442",
          "website": "hildegard.org",
          "company": [
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
        ]
    ]
    
    func testCreateUserFromPayload() {
        if let user = User.createUserFromPayload(samplePayload) {
            XCTAssert(user.id == 1)
            XCTAssert(user.name == "Leanne Graham")
            XCTAssert(user.username == "Bret")
            XCTAssert(user.email == "Sincere@april.biz")
            XCTAssert(user.address?.street == "Kulas Light")
            XCTAssert(user.address?.suite == "Apt. 556")
            XCTAssert(user.address?.city == "Gwenborough")
            XCTAssert(user.address?.zipcode == "92998-3874")
            XCTAssert(user.address?.coordinates?.lat == "-37.3159")
            XCTAssert(user.address?.coordinates?.long == "81.1496")
            XCTAssert(user.phone == "1-770-736-8031 x56442")
            XCTAssert(user.website == "hildegard.org")
            XCTAssert(user.company?.companyName == "Romaguera-Crona")
            XCTAssert(user.company?.companyPhrase == "Multi-layered client-server neural-net")
            XCTAssert(user.company?.companyDesc == "harness real-time e-markets")
        }
        else {
            XCTFail("User not created")
        }
    }
    
    func testSaveAndRetrieve() {
        let ctUser = CTUser()
        ctUser.username = "elijah98"
        ctUser.password = "password123"
        ctUser.countryOfOrigin = "Philippines"
        
        CTUserPersistence.shared.save(ctUser: ctUser)
        sleep(2)
        
        CTUserPersistence.shared.retrieve(username: ctUser.username) { (success, user) in
            if success {
                guard let user = user else {
                    XCTFail("Save failed")
                    return
                }
                XCTAssert(user.username == ctUser.username)
                XCTAssert(user.password == ctUser.password)
                XCTAssert(user.countryOfOrigin == ctUser.countryOfOrigin)
            }
            else {
                XCTFail("Fetching failed")
            }
        }
    }
    
    func testValidate() {
        let ctUser = CTUser()
        ctUser.username = "elijahTest1"
        ctUser.password = "pass1298"
        ctUser.countryOfOrigin = "Philippines"
        
        CTUserPersistence.shared.save(ctUser: ctUser)
        sleep(2)
        
        CTUserPersistence.shared.validate(username: ctUser.username, password: ctUser.password) { (success) in
            XCTAssert(success)
        }
        
        CTUserPersistence.shared.validate(username: ctUser.username, password: "randomPassword") { (success) in
            XCTAssert(!success)
        }
    }
}
