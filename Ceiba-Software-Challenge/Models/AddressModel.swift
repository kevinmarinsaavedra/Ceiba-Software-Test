//
//  AddressModel.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?

    enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }
}
