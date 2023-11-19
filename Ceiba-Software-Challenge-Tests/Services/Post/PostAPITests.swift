//
//  PostAPITests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 14/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class PostAPITests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!

    var networkingServiceMock: NetworkServiceMock<[Post]>!
    var sut: PostAPI!
    
    override func setUpWithError() throws {
        networkingServiceMock = NetworkServiceMock()
        sut = PostAPI(networkService: networkingServiceMock)
    }
    
    override func tearDownWithError() throws {
        networkingServiceMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_fetchPosts_success() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        networkingServiceMock.dataDecoder = [Post(), Post(), Post()]

        var spySuccess: Bool = false
        var resultData: [Post]!
    
        let parameters = PostParameters(userId: 1)

        //Act
        sut.fetchPosts(parameters: parameters) { result in
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
    
    func test_fetchPosts_failure_parameters() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        networkingServiceMock.dataDecoder = [Post(), Post(), Post()]
        let expectedError: ErrorService = .parameters

        var spyFailure: Bool = false
        var resultError: ErrorService!
    
        //Act
        sut.fetchPosts(parameters: nil) { result in
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
        XCTAssertEqual(resultError, expectedError, "It's error in parameters")
    }
    
    func test_fetchPosts_failure_parsing() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        let error: ErrorService = .parse(description: "The data couldn’t be read because it is missing.")
        networkingServiceMock.throwError = error
        let expectedError: ErrorService = error

        var spyFailure: Bool = false
        var resultError: ErrorService!
    
        let parameters = PostParameters(userId: 1)
        
        //Act
        sut.fetchPosts(parameters: parameters) { result in
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
        XCTAssertEqual(resultError, expectedError, "It's error parsing")
    }
    
    func test_fetchPosts_failure_unspecified() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        let error: ErrorService = .unspecified
        networkingServiceMock.throwError = error
        let expectedError: ErrorService = error

        var spyFailure: Bool = false
        var resultError: ErrorService!
    
        let parameters = PostParameters(userId: 1)
        
        //Act
        sut.fetchPosts(parameters: parameters) { result in
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
        XCTAssertEqual(resultError, expectedError, "It's error parsing")
    }
}
