//
//  GeoModel.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

// MARK: - Geo
struct Geo: Codable {
    let lat: String?
    let lng: String?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}
