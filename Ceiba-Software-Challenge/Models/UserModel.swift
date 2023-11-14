//
//  User.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

// MARK: - User
struct User: Codable, Equatable {
    var id: Int? = nil
    var name: String? = nil
    var username: String? = nil
    var email: String? = nil
    var address: Address? = nil
    var phone: String? = nil
    var website: String? = nil
    var company: Company? = nil

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
