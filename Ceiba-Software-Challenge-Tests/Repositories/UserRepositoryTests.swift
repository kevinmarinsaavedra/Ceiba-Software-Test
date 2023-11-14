//
//  UserRepositoryTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 14/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class UserRepositoryTests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    let filename = "Users"
    
    var userServiceMock: UserServiceMock!
    var localDatabaseManagerMock: LocalDatabaseManagerMock!
    var sut: UserRepository!

    override func setUpWithError() throws {
        userServiceMock = UserServiceMock()
        localDatabaseManagerMock = LocalDatabaseManagerMock()
        sut = UserRepository(userService: userServiceMock, localDatabaseManager: localDatabaseManagerMock)
    }
    
    override func tearDownWithError() throws {
        userServiceMock = nil
        localDatabaseManagerMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_fetchUser_localData_success() {
        //Arrange
        let data: [User] = [User(), User(), User()]
        
        expAsync = expectation(description: "waiting for data")
        localDatabaseManagerMock.users = data
        var resultData: [User]!
        
        let expectedData: [User] = data
        
        //Act
        sut.fetchUser { result in
            switch result {
            case .success(let data): resultData = data
            case .failure(_): break
            }
        }
        
        self.awaitExpAsync()
        
        //Assert
        XCTAssertTrue(localDatabaseManagerMock.spyGetUsers)
        XCTAssertEqual(resultData, expectedData)
    }
    
    func test_fetchUser_userService_success() {
        //Arrange
        userServiceMock.filename = filename
        
        expAsync = expectation(description: "waiting for data")
        var resultData: [User]!
        
        //Act
        sut.fetchUser { result in
            switch result {
            case .success(let data): resultData = data
            case .failure(_): break
            }
        }
        
        self.awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userServiceMock.spyFetchUser)
        XCTAssertFalse(resultData.isEmpty, "Should not be an array empty")
    }
    
    func test_fetchUser_userService_failure() {
        //Arrange
        let error: ErrorService = .unspecified

        expAsync = expectation(description: "waiting for data")
        userServiceMock.throwError = .unspecified
        var resultError: ErrorService!
        
        let expectedError: ErrorService = error
        
        //Act
        sut.fetchUser { result in
            switch result {
            case .success(_): break
            case .failure(let error): resultError = error
            }
        }
        
        self.awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userServiceMock.spyFetchUser)
        XCTAssertEqual(resultError, expectedError)
    }
}