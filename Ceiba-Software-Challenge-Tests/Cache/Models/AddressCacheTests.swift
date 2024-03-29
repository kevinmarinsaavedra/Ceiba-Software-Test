//
//  AddressCacheTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 25/11/23.
//

import XCTest
import RealmSwift
@testable import Ceiba_Software_Challenge

class AddressCacheTests: XCTestCase {

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

    func test_addressCache_initialization() {
        // Arrange
        let geo = GeoCache()
        let address = AddressCache(street: "123 Main St", 
                                   suite: "Apt 4",
                                   city: "City",
                                   zipcode: "12345",
                                   geo: geo)

        // Act
        try! realm.write {
            realm.add(address)
        }

        // Assert
        let retrievedAddress = realm.objects(AddressCache.self).first
        XCTAssertNotNil(retrievedAddress, "Expected to retrieve an address")
        XCTAssertEqual(retrievedAddress?.street, "123 Main St", "Unexpected street address")
        XCTAssertEqual(retrievedAddress?.suite, "Apt 4", "Unexpected suite information")
        XCTAssertEqual(retrievedAddress?.city, "City", "Unexpected city name")
        XCTAssertEqual(retrievedAddress?.zipcode, "12345", "Unexpected zipcode")
    }
}
