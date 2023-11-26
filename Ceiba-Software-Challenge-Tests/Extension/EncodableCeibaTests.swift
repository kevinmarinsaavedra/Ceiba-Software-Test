//
//  Encodable+ceibaTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 25/11/23.
//

import Foundation
import XCTest
@testable import Ceiba_Software_Challenge

class EncodableCeibaTests: XCTestCase {

    func testAsDictionary() {
        //Arrange
        let mockData = MockCodableType(property: "mock")
        var dictionaryResult: [String: Any]!
        
        //Act
        do {
            dictionaryResult = try mockData.asDictionary()
        } catch {
            XCTFail("Error converting to dictionary: \(error)")
        }
        
        //Assert
        let expectedDictionary: [String: Any] = ["property": "mock"]
        XCTAssertEqual(dictionaryResult as NSDictionary, expectedDictionary as NSDictionary)
    }
}

extension EncodableCeibaTests {
    struct MockCodableType: Encodable {
        let property: String
    }
}
