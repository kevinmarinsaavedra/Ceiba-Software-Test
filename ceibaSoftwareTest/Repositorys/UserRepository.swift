//
//  UserRepository.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 16/9/21.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser( completion: @escaping (Result<[User],ErrorService>) -> Void)
}

final class UserRepository: UserRepositoryProtocol {
    
    var userService: UserServiceProtocol?
    var localDatabaseManager: LocalDatabaseManager

    
    init(userService: UserServiceProtocol, localDatabaseManager: LocalDatabaseManager) {
        self.userService = userService
        self.localDatabaseManager = localDatabaseManager
    }
    
    func fetchUser(completion: @escaping (Result<[User], ErrorService>) -> Void) {
        
        let users = localDatabaseManager.getUsers()
        
        if !users.isEmpty {
            completion(.success(users))
        } else {
            userService?.fetchUser(completion: { (result) in
                switch result {
                case .success(let users):
                    
                    //save in local database
                    self.localDatabaseManager.setUsers(users: users)
                    
                    completion(result)
                case .failure(_):
                    completion(result)
                }
            })
        }
                
    }
}
