//
//  PostRepository.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 14/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class PostRepositoryTests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    var filename: String = "Posts"
    
    var postServiceMock: PostServiceMock!
    var sut: PostRepository!
    
    override func setUpWithError() throws {
        postServiceMock = PostServiceMock()
        sut = PostRepository(postService: postServiceMock)
    }
    
    override func tearDownWithError() throws {
        postServiceMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_fetchPosts_service_success() {
        // Arrange
        expAsync = expectation(description: "waiting for data")
        postServiceMock.filename = filename
        var resultData: [Post]!
        
        // Act
        sut.fetchPosts(parameters: nil) { result in
            switch result {
            case .success(let data): resultData = data
            case .failure(_): break
            }
        }
        awaitExpAsync()
        
        // Assert
        XCTAssertTrue(postServiceMock.spyFetchPosts, "It's should be called fetchPosts")
        XCTAssertFalse(resultData.isEmpty, "Should not be an array empty")
    }
}
