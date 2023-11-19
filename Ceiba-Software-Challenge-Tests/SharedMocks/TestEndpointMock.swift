//
//  TestEndpointMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 18/11/23.
//

import Foundation
import Alamofire
@testable import Ceiba_Software_Challenge

enum TestEndpointMock {
    case fetchData(method: HTTPMethod,
                    path: String,
                    parameters: Parameters?,
                    header: HTTPHeaders?,
                    interceptor: RequestInterceptor?,
                    encoding: ParameterEncoding)
}

extension TestEndpointMock: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .fetchData(let method, _, _, _, _, _):
            return method
        }
    }
    
    var path: String {
        switch self {
        case .fetchData(_, let path, _, _, _, _):
            return path
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .fetchData(_, _, let parameters, _, _, _):
            return parameters
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .fetchData(_, _, _, let header, _, _):
            return header
        }
    }
    
    var interceptor: RequestInterceptor? {
        switch self {
        case .fetchData(_, _, _, _, let interceptor, _):
            return interceptor
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchData(_, _, _, _, _, let encoding):
            return encoding
        }
    }
}
