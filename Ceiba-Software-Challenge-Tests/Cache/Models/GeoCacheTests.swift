//
//  GeoCacheTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 25/11/23.
//

import XCTest
import RealmSwift
@testable import Ceiba_Software_Challenge

class GeoCacheTests: XCTestCase {

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

    func test_geoCache_Initialization() {
        // Arrange
        let geo = GeoCache(lat: "10.2213454", lng: "-7.2213454")

        // Act
        try! realm.write {
            realm.add(geo)
        }

        // Assert
        let retrievedGeo = realm.objects(GeoCache.self).first
        XCTAssertNotNil(retrievedGeo)
        XCTAssertEqual(retrievedGeo?.lat, "10.2213454")
        XCTAssertEqual(retrievedGeo?.lng, "-7.2213454")
    }
}
