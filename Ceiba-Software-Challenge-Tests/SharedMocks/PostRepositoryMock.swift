//
//  PostRepositoryMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 11/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class PostRepositoryMock: PostRepositoryProtocol, RepositoryUtils {
    var filename: String?
    var throwError: ErrorService?
    var defaultData: [Post] = []
    
    func fetchPosts(parameters: PostParameters?, completion: @escaping (Result<[Post], ErrorService>) -> Void) {
        Task {
            do {
                let result = try await self.fetchData(filename, throwError, defaultData)
                completion(.success(result))
            } catch {
                completion(.failure(error as? ErrorService ?? .unspecified))
            }
        }
    }
}
