//
//  PostModelTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 18/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge


class PostModelTests: XCTestCase {
    
    func test_postCodable() {
        //Arrange
        let sut = Post(userID: 1, id: 1, title: "happy friday", body: "thanks so much team")
        var decodedPost: Post!
        
        //Act
        do {
            let data = try JSONEncoder().encode(sut)
            decodedPost = try JSONDecoder().decode( Post.self, from: data)
        } catch {
            XCTFail("Error parsing data")
            return
        }
        
        //Assert
        XCTAssertEqual(sut, decodedPost, "Encoded and decoded users should match")
    }
    
    func test_postEquatable() {
        //Arrange
        let post1 = Post(userID: 1, id: 1, title: "happy friday", body: "thanks so much team")
        let post2 = Post(userID: 1, id: 1, title: "happy saturday", body: "thanks so much people")
        let post3 = Post(userID: 2, id: 2, title: "happy sunday", body: "thanks so much guys")
        
        //Act
        
        //Assert
        XCTAssertEqual(post1, post2, "Post with the same ID's should be equal")
        XCTAssertNotEqual(post1, post3, "Post with different ID's should not be equal")
    }
}
