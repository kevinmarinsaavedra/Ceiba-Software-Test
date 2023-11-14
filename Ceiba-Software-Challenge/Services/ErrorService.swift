//
//  ErrorService.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

enum ErrorService: Error, CustomStringConvertible {
    case network(description: String)
    case parse(description: String)
    case unspecified
    case parameters
    
    var title: String {
        return self.description
    }
    
    var description: String {
        switch self {
        case .network(let description), .parse(let description):
            return description
        case .unspecified:
            return "Unexpected error"
        case .parameters:
            return "Error encoding parameters"
        }
    }
}
