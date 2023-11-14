//
//  AppCoordinatorTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 31/10/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class AppCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    
    override func setUpWithError() throws {
        sut = AppCoordinator()
        _ = sut.start()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_navigation() {
        //Arrange
        let user: User = User()
        let router: Route = .userDetails(user: user)
        
        //Act
        sut.navigate(router)
        
        //Assert
        guard let viewController = sut.navController?.topViewController as? UserListViewController else {
            XCTFail("It's should be of type UserListViewController")
            return
        }
        
        XCTAssertNotNil(viewController, "It's should not be viewController")
    }
}
