//
//  NetworkingServiceMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 17/11/23.
//

import Foundation
@testable import Ceiba_Software_Challenge

class NetworkingServiceMock<D: Encodable>: NetworkServiceProtocol {
    var throwError: ErrorService!
    var dataDecoder: D!
    
    func request<T>(endpoint: T, completion: @escaping (Result<Data, ErrorService>) -> Void) where T : IEndpoint {
        if let throwError {
            switch throwError{
            case .parse(_):
                dataDecoder = [ParsingErrorModel(), ParsingErrorModel(), ParsingErrorModel()] as? D
            default:
                completion(.failure(throwError))
                return
            }
        }
        
        do {
            let data = try JSONEncoder().encode(dataDecoder)
            completion(.success(data))
        } catch {
            completion(.failure(.parse(description: "error parsing input data")))
        }
    }
}

// MARK: - User
struct ParsingErrorModel: Codable, Equatable {
    var property: Int? = nil

    enum CodingKeys: String, CodingKey {
        case property = "property"
    }
    
    static func == (lhs: ParsingErrorModel, rhs: ParsingErrorModel) -> Bool {
        return lhs.property == rhs.property
    }
}
