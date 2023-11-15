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
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.path, "\(Ceiba.BaseURL.URL)/users")
        XCTAssertNil(endpoint.parameter)
        XCTAssertNil(endpoint.header)
        XCTAssertNil(endpoint.interceptor)
        XCTAssertTrue(endpoint.encoding is JSONEncoding)
    }
}
