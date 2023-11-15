//
//  UserModelTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 15/11/23.
//

import Foundation
import XCTest
@testable import Ceiba_Software_Challenge

class UserModelTests: XCTestCase {
    
    func test_userCodable() throws {
        //Arrange
        let user = User(id: 1, name: "John Doe", username: "john_doe", email: "john@example.com",
                        address: nil, phone: "123456789", website: "example.com", company: nil)

        //Act
        let data = try JSONEncoder().encode(user)
        let decodedUser = try JSONDecoder().decode(User.self, from: data)
        
        //Assert
        XCTAssertEqual(user, decodedUser, "Encoded and decoded users should match")
    }
    
    func test_userEquatable() {
        // Arrange
        let user1 = User(id: 1, name: "John Doe", username: "john_doe", email: "john@example.com",
                         address: nil, phone: "123456789", website: "example.com", company: nil)
        let user2 = User(id: 1, name: "John Doe", username: "john_doe", email: "john@example.com",
                         address: nil, phone: "123456789", website: "example.com", company: nil)
        let user3 = User(id: 2, name: "Jane Doe", username: "jane_doe", email: "jane@example.com",
                         address: nil, phone: "987654321", website: "example2.com", company: nil)

        // Assert
        XCTAssertEqual(user1, user2, "Users with the same ID should be equal")
        XCTAssertNotEqual(user1, user3, "Users with different IDs should not be equal")
    }
}
