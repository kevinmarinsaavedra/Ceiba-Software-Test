//
//  UserListModels.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 19/9/21.
//

import Foundation

enum  UserList {
  
    struct ViewModel {
        var users: [User] = [] {
            didSet {
                applyFilter()
            }
        }
        var usersFilter: [User] = []
        var searchBy: String = "" {
            didSet {
                applyFilter()
            }
        }
        
        private mutating func applyFilter() {
            if searchBy.isEmpty {
                usersFilter = users
            } else {
                usersFilter = users.filter({
                    let name = $0.name?.uppercased() ?? ""
                    return name.contains(searchBy.uppercased())
                })
            }
        }
    }
}
