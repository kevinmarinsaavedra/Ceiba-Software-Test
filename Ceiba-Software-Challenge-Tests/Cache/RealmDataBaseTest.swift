//
//  RealmDataBaseTest.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 25/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class RealmDataBaseTests: XCTestCase {
    var sut: RealmDataBase!

    override func setUpWithError() throws {
        sut = RealmDataBase(identifier: "testRealm")
        sut.resetDB()
    }

    override func tearDownWithError() throws {
        sut.resetDB()
    }

    func test_getUsers_and_setUsers() {
        //Arrange
        let geo = Geo(lat: "20.7854", 
                      lng: "20.7854")
        let address = Address(street: "123 Main St",
                                   suite: "Apt 4",
                                   city: "City",
                                   zipcode: "12345",
                                   geo: geo)
        let company = Company(name: "ABC Inc",
                                   catchPhrase: "Connecting People",
                                   bs: "Best Service")
        let user = User(id: 1,
                        name: "John Doe",
                        username: "john.doe",
                        email: "john.doe@example.com",
                        address: address,
                        phone: "123456789",
                        website: "www.example.com",
                        company: company)
        let users = [user]

        //Act
        sut.setUsers(users: users)
        let retrievedUsers = sut.getUsers()

        // Assert
        XCTAssertEqual(retrievedUsers.count, 1, "Expected there to be one user in the database.")
        XCTAssertEqual(retrievedUsers.first?.name, "John Doe", "The name of the retrieved user doesn't match the expected value.")
    }
}
