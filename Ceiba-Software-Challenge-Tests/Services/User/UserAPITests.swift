//
//  UserAPITests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 14/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class UserAPITests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    
    var networkingServiceMock: NetworkServiceMock<[User]>!
    var sut: UserAPI!
    
    override func setUpWithError() throws {
        networkingServiceMock = NetworkServiceMock()
        sut = UserAPI(networkService: networkingServiceMock)
    }
    
    override func tearDownWithError() throws {
        networkingServiceMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_fetchUser_success() {
        // Arrange
        expAsync = expectation(description: "waiting for data")
        networkingServiceMock.dataDecoder = [User(), User(), User()]

        var spySuccess: Bool = false
        var resultData: [User]!

        // Act
        sut.fetchUser { result in
            switch result {
            case .success(let data):
                spySuccess = true
                resultData = data
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        }

        awaitExpAsync()

        //Assert
        XCTAssertTrue(spySuccess, "It's should be True")
        XCTAssertFalse(resultData.isEmpty, "It's should not be an array empty")
    }
    
    func test_fetchUser_failure_unspecified() {
        // Arrange
        expAsync = expectation(description: "waiting for data")
        networkingServiceMock.throwError = .unspecified
        let expectedError: ErrorService = .unspecified

        var spyFailure: Bool = false
        var resultError: ErrorService!
        
        // Act
        sut.fetchUser { result in
            switch result {
            case .success(let data):
                XCTFail("Unexpected success: \(data)")
            case .failure(let error):
                spyFailure = true
                resultError = error
            }
        }

        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(spyFailure, "It's should be True")
        XCTAssertEqual(resultError, expectedError)
    }
    
    func test_fetchUser_failure_parsing() {
        // Arrange
        expAsync = expectation(description: "waiting for data")
        let error: ErrorService = .parse(description: "The data couldn’t be read because it is missing.")
        networkingServiceMock.throwError = error
        let expectedError: ErrorService = error

        var spyFailure: Bool = false
        var resultError: ErrorService!
        
        // Act
        sut.fetchUser { result in
            switch result {
            case .success(let data):
                XCTFail("Unexpected success: \(data)")
            case .failure(let error):
                spyFailure = true
                resultError = error
            }
        }

        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(spyFailure, "It's should be True")
        XCTAssertEqual( resultError , expectedError)
    }
}
