//
//  PostEndpoint.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation
import Alamofire

enum PostEndpoint {    
    case fetchPosts(parameters: Parameters? = .none)
}

extension PostEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .fetchPosts:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchPosts:
            return "\(Ceiba.BaseURL.URL)/posts"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .fetchPosts(let parameters):
            return parameters
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .fetchPosts:
            return nil
        }
    }
    
    var interceptor: RequestInterceptor? {
        switch self {
        case .fetchPosts:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchPosts:
            return URLEncoding.queryString
        }
    }
}
