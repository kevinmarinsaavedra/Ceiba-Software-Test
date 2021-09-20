//
//  UserEndpoint.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation
import  Alamofire

enum UserEndpoint {
    case fetchUsers
}

extension UserEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .fetchUsers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchUsers:
            return "\(Ceiba.BaseURL.URL)/users"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .fetchUsers:
            return .none
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .fetchUsers:
            return nil
        }
    }
    
    var interceptor: RequestInterceptor? {
        switch self {
        case .fetchUsers:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchUsers:
            return JSONEncoding.default
        }
    }
}
