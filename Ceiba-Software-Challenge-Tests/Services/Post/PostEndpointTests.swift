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
        XCTAssertEqual(endpoint.method, .get, "Expected HTTP method to be GET")
        XCTAssertEqual(endpoint.path, "\(Ceiba.BaseURL.URL)/posts", "Unexpected endpoint path")
        XCTAssertNotNil(endpoint.parameter, "Expected parameters to be non-nil")
        XCTAssertNil(endpoint.header, "Expected headers to be nil")
        XCTAssertNil(endpoint.interceptor, "Expected interceptor to be nil")
        XCTAssertTrue(endpoint.encoding is URLEncoding, "Expected encoding to be URLEncoding")
    }
}
