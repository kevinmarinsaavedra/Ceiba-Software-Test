//
//  UserAPI.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

protocol UserServiceProtocol  {
    func fetchUser( completion: @escaping (Result<[User],ErrorService>) -> Void)
}

final class UserAPI: UserServiceProtocol {
    
    private let networkService: any NetworkServiceRequestProtocol
    
    init(networkService: any NetworkServiceRequestProtocol = NetworkService.share) {
        self.networkService = networkService
    }
    
    func fetchUser( completion: @escaping (Result<[User], ErrorService>) -> Void) {
                
        networkService.request(endpoint: UserEndpoint.fetchUsers) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(description: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
