//
//  LocalDatabaseManagerMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 14/11/23.
//

import Foundation
@testable import Ceiba_Software_Challenge

class LocalDatabaseManagerMock: LocalDatabaseManager {
    var users: [User] = []
    var spyGetUsers: Bool = false
    var spySetUsers: Bool = false
    
    func getUsers() -> [User] {
        spyGetUsers = true
        return users
    }
    
    func setUsers(users: [User]) {
        spySetUsers = true
        self.users = users
    }
}
