//
//  PostRepository.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

protocol PostRepositoryProtocol {
    func fetchPosts( parameters: PostParameters?, completion: @escaping (Result<[Post],ErrorService>) -> Void)
}

final class PostRepository: PostRepositoryProtocol {
    
    var postService: PostServiceProtocol
    
    init(postService: PostServiceProtocol) {
        self.postService = postService
    }
    
    func fetchPosts( parameters: PostParameters?, completion: @escaping (Result<[Post], ErrorService>) -> Void) {
        postService.fetchPost(parameters: parameters) { (result) in
            completion(result)
        }
    }
}
