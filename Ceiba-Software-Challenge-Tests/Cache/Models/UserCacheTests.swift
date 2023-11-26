//
//  UserCacheTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 25/11/23.
//

import XCTest
import RealmSwift
@testable import Ceiba_Software_Challenge

class UserCacheTests: XCTestCase {

    var realm: Realm!

    override func setUpWithError() throws {
        super.setUp()
        let configuration = Realm.Configuration(inMemoryIdentifier: "testRealm")
        realm = try! Realm(configuration: configuration)
    }

    override func tearDownWithError() throws {
        try! realm.write {
            realm.deleteAll()
        }
        super.tearDown()
    }

    func test_userCache_initialization() {
        // Arrange
        let geo = GeoCache()
        let address = AddressCache(street: "123 Main St", 
                                   suite: "Apt 4",
                                   city: "City", 
                                   zipcode: "12345",
                                   geo: geo)
        let company = CompanyCache(name: "ABC Inc", 
                                   catchPhrase: "Connecting People",
                                   bs: "Best Service")
        let user = UserCache(id: 1, 
                             name: "Pablo",
                             username: "Llanos",
                             email: "test@test.com",
                             address: address,
                             phone: "555555",
                             website: "www.test.com",
                             company: company)

        // Act
        try! realm.write {
            realm.add(user)
        }

        // Assert
        let retrievedUser = realm.objects(UserCache.self).first
        XCTAssertEqual(retrievedUser?.id, 1, "Expected user ID to be 1")
        XCTAssertEqual(retrievedUser?.name, "Pablo", "Unexpected user name")
        XCTAssertEqual(retrievedUser?.username, "Llanos", "Unexpected username")
        XCTAssertEqual(retrievedUser?.email, "test@test.com", "Unexpected email address")
        XCTAssertEqual(retrievedUser?.phone, "555555", "Unexpected phone number")
        XCTAssertEqual(retrievedUser?.website, "www.test.com", "Unexpected website URL")
    }
}
