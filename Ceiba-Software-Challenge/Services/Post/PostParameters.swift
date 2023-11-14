//
//  PostParameters.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 11/11/23.
//

import Foundation

struct PostParameters: Codable {
    let userId: Int?

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
    }
}
