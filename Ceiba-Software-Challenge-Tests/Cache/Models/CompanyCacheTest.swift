//
//  CompanyCacheTest.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 25/11/23.
//

import XCTest
import RealmSwift
@testable import Ceiba_Software_Challenge

class CompanyCacheTests: XCTestCase {

    // Configuración específica para las pruebas
    var realm: Realm!

    override func setUp() {
        // Configuración de Realm en memoria para las pruebas
        let configuration = Realm.Configuration(inMemoryIdentifier: "testRealm")
        realm = try! Realm(configuration: configuration)
    }

    override func tearDown() {
        // Limpiar la base de datos en memoria después de cada prueba
        try! realm.write {
            realm.deleteAll()
        }
    }

    func test_companyCache_initialization() {
        // Arrange
        let company = CompanyCache(name: "ABC Inc",
                                   catchPhrase: "Connecting People",
                                   bs: "Best Service")

        // Act
        try! realm.write {
            realm.add(company)
        }

        // Assert
        let retrievedCompany = realm.objects(CompanyCache.self).first
        XCTAssertNotNil(retrievedCompany)
        XCTAssertEqual(retrievedCompany?.name, "ABC Inc")
        XCTAssertEqual(retrievedCompany?.catchPhrase, "Connecting People")
        XCTAssertEqual(retrievedCompany?.bs, "Best Service")
    }
}
