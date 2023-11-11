//
//  CoordinatorMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 31/10/23.
//

import UIKit
@testable import Ceiba_Software_Challenge

class CoordinatorMock: BaseCoordinator {
    
    var spyNavigateToUserDetails: Bool = false
    
    func start() -> UINavigationController {
        return UINavigationController()
    }
    
    func navigate(_ router: Route) {
        switch router {
        case .userDetails(_):
            spyNavigateToUserDetails = true
        }
    }
}
