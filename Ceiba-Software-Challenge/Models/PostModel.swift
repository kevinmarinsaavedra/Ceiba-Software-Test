//
//  PostModel.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

// MARK: - Post

enum Post {
    struct Model: Codable {
        let userID: Int?
        let id: Int?
        let title: String?
        let body: String?

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case id = "id"
            case title = "title"
            case body = "body"
        }
    }
    
    struct Parameters: Codable {
        let userId: Int?

        enum CodingKeys: String, CodingKey {
            case userId = "userId"
        }
    }
}


