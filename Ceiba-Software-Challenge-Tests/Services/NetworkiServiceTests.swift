//
//  NetworkiServiceTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 18/11/23.
//

import XCTest
import Alamofire
@testable import Ceiba_Software_Challenge

class NetworkiServiceTests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    
    func test_request_success() {
        //Arrange
        expAsync = expectation(description: "waiting for data")

        var spySuccess: Bool = false
        var resultData: Data!
        
        let parameters: PostParameters? = PostParameters(userId: 1)
            
        guard let parameter = (parameters != nil) ? try? parameters.asDictionary() : nil else {
            XCTFail("Unexpected failure")
            return
        }
    
        let endpoint = TestEndpointMock.fetchData(
            method: .get,
            path: "https://jsonplaceholder.typicode.com/posts",
            parameters: parameter,
            header: nil,
            interceptor: nil,
            encoding: URLEncoding.queryString)
        
        //Act
        _ = NetworkService.share.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                spySuccess = true
                resultData = data
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        }
        
        awaitExpAsync(deadline: 3.0, timeOut: 5.0)
        
        //Assert
        XCTAssertTrue(spySuccess, "It's should be True")
        XCTAssertFalse(resultData.isEmpty, "It's should not be empty")
    }
    
    func test_request_failure_network() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        let expectedError: ErrorService = .network(description: "Response status code was unacceptable: 404.")

        var spyFailure: Bool = false
        var resultError: ErrorService!
        
        let parameters: PostParameters? = PostParameters(userId: 1)
            
        guard let parameter = (parameters != nil) ? try? parameters.asDictionary() : nil else {
            XCTFail("Unexpected failure")
            return
        }
    
        let endpoint = TestEndpointMock.fetchData(
            method: .get,
            path: "https://jsonplaceholder.typicode.com/tests",
            parameters: parameter,
            header: nil,
            interceptor: nil,
            encoding: URLEncoding.queryString)
        
        //Act
        _ = NetworkService.share.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                XCTFail("Unexpected success: \(data)")
            case .failure(let error):
                spyFailure = true
                resultError = error
            }
        }
        
        awaitExpAsync(deadline: 3.0, timeOut: 5.0)
        
        //Assert
        XCTAssertTrue(spyFailure, "It's should be True")
        XCTAssertEqual(resultError, expectedError, "It's error network")
    }
    
    func test_cancelRequest() {
        //Arrange
        expAsync = expectation(description: "waiting for execution")
        var spyRequest: Bool = false
        var spyCompletion: Bool = false
        
        let sessionDelegate = TestURLSession()
        let interceptorAdapter = RequestInterceptorAdapter(sessionDelegate)
        let endpoint = TestEndpointMock.fetchData(
            method: .get,
            path: "https://jsonplaceholder.typicode.com/posts",
            parameters: .none,
            header: nil,
            interceptor: interceptorAdapter,
            encoding: URLEncoding.queryString)
        
        //Act
        var request: DataRequest?

        request = NetworkService.share.request(endpoint: endpoint) { result in
            switch result {
            case .success(_):
                spyRequest = true
            case .failure(_):
                spyRequest = false
            }
        }
                
        NetworkService.share.cancelRequest(request: request!) {
            spyCompletion = true
        }

        awaitExpAsync(deadline: 2.0)
        
        //Assert
        XCTAssertFalse(spyRequest, "It should be False")
        XCTAssertTrue(spyCompletion, "It should be True")
    }
    
    func test_cancelAllRequest() {
        //Arrange
        expAsync = expectation(description: "waiting for execution")
        var spyRequest: Bool = false
        var spyCompletion: Bool = false
        
        let sessionDelegate = TestURLSession()
        let interceptorAdapter = RequestInterceptorAdapter(sessionDelegate)
        let endpoint = TestEndpointMock.fetchData(
            method: .get,
            path: "https://jsonplaceholder.typicode.com/posts",
            parameters: .none,
            header: nil,
            interceptor: interceptorAdapter,
            encoding: URLEncoding.queryString)
        
        //Act
        _ = NetworkService.share.request(endpoint: endpoint) { result in
            switch result {
            case .success(_):
                spyRequest = true
            case .failure(_):
                spyRequest = false
            }
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            NetworkService.share.cancelAllRequest() {
                spyCompletion = true
            }
        }

        awaitExpAsync(deadline: 2.0)
        
        //Assert
        XCTAssertFalse(spyRequest, "It should be False")
        XCTAssertTrue(spyCompletion, "It should be True")
    }
}
