//
//  UserEndpointTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 14/11/23.
//

import XCTest
import Alamofire
@testable import Ceiba_Software_Challenge

class UserEndpointTests: XCTestCase {
    
    func test_usersEndpoint_fetchUsers() {
        //Arrange
        let endpoint = UserEndpoint.fetchUsers

        //Act
        
        //Assert
        XCTAssertEqual(endpoint.method, .get, "Expected HTTP method to be GET")
        XCTAssertEqual(endpoint.path, "\(Ceiba.BaseURL.URL)/users", "Unexpected endpoint path")
        XCTAssertNil(endpoint.parameter, "Expected parameters to be nil")
        XCTAssertNil(endpoint.header, "Expected headers to be nil")
        XCTAssertNil(endpoint.interceptor, "Expected interceptor to be nil")
        XCTAssertTrue(endpoint.encoding is JSONEncoding, "Expected encoding to be JSONEncoding")
    }
}
