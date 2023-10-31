//
//  CompanyModel.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

// MARK: - Company
struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}
