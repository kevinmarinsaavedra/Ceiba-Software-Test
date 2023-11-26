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

    // Configuración específica para las pruebas
    var realm: Realm!

    override func setUpWithError() throws {
        super.setUp()
        // Configuración de Realm en memoria para las pruebas
        let configuration = Realm.Configuration(inMemoryIdentifier: "testRealm")
        realm = try! Realm(configuration: configuration)
    }

    override func tearDownWithError() throws {
        // Limpiar la base de datos en memoria después de cada prueba
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
        XCTAssertNotNil(retrievedUser)
        XCTAssertEqual(retrievedUser?.id, 1)
        XCTAssertEqual(retrievedUser?.name, "Pablo")
        XCTAssertEqual(retrievedUser?.username, "Llanos")
        XCTAssertEqual(retrievedUser?.email, "test@test.com")
        XCTAssertEqual(retrievedUser?.phone, "555555")
        XCTAssertEqual(retrievedUser?.website, "www.test.com")
    }
}
