//
//  File.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 31/10/23.
//

import Foundation
@testable import Ceiba_Software_Challenge

class UserRepositoryMock: UserRepositoryProtocol, RepositoryUtils {
    var filename: String?
    var throwError: ErrorService?
    var defaultData: [User] = []
    
    var spyFetchUser: Bool = false
    
    func fetchUser(completion: @escaping (Result<[User], ErrorService>) -> Void) {
        
        spyFetchUser = true

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
