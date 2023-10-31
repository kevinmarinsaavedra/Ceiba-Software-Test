//
//  PostAPI.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

protocol PostServiceProtocol  {
    func fetchPost( parameters: Post.Parameters?, completion: @escaping (Result<[Post.Model],ErrorService>) -> Void)
}

final class PostAPI: PostServiceProtocol {
    
    func fetchPost(parameters: Post.Parameters?, completion: @escaping (Result<[Post.Model], ErrorService>) -> Void) {
        
        guard let parameter = (parameters != nil) ? try? parameters.asDictionary() : nil else {
            completion(.failure(ErrorService.parameters))
            return
        }
        
        NetworkService.share.request(endpoint: PostEndpoint.fetchPosts(parameters: parameter)) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode([Post.Model].self, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
