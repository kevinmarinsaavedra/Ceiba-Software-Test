//
//  PostAPI.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

protocol PostServiceProtocol  {
    func fetchPosts( parameters: PostParameters?, completion: @escaping (Result<[Post],ErrorService>) -> Void)
}

final class PostAPI: PostServiceProtocol {
    
    private let networkService: any NetworkServiceProtocol
    
    init(networkService: any NetworkServiceProtocol = NetworkService.share) {
        self.networkService = networkService
    }
    
    func fetchPosts(parameters: PostParameters?, completion: @escaping (Result<[Post], ErrorService>) -> Void) {
        
        guard let parameter = (parameters != nil) ? try? parameters.asDictionary() : nil else {
            completion(.failure(ErrorService.parameters))
            return
        }
        
        networkService.request(endpoint: PostEndpoint.fetchPosts(parameters: parameter)) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode([Post].self, from: data)
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
