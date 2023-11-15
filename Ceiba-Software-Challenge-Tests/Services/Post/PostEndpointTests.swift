//
//  PostEndpointTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 14/11/23.
//

import XCTest
import Alamofire
@testable import Ceiba_Software_Challenge

class PostEndpointTests: XCTestCase {
    
    func test_postEndpoint_fetchPosts() {
        //Arrange
        let parametersMock: Parameters = Parameters()
        let endpoint = PostEndpoint.fetchPosts(parameters: parametersMock)

        //Act
        
        //Assert
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.path, "\(Ceiba.BaseURL.URL)/posts")
        XCTAssertNotNil(endpoint.parameter)
        XCTAssertNil(endpoint.header)
        XCTAssertNil(endpoint.interceptor)
        XCTAssertTrue(endpoint.encoding is URLEncoding)
    }
}
