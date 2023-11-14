//
//  File.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 31/10/23.
//

import Foundation
@testable import Ceiba_Software_Challenge

class UserRepositoryMock: UserRepositoryProtocol, RepositoryUtils {
    var filename: String? = nil
    var throwError: ErrorService? = nil
    var defaultData: [User] = []
    
    func fetchUser(completion: @escaping (Result<[User], ErrorService>) -> Void) {
        
        Task {
            do {
                let users = try await fetchData(filename, throwError, defaultData)
                completion(.success(users))
            } catch {
                completion(.failure(error as? ErrorService ?? .unspecified))
            }
        }
    }
}
