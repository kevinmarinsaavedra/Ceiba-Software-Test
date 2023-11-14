//
//  UserListPresenter.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 31/10/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class UserListPresenterTests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    let filename = "Users"
    
    var userRepositoryMock: UserRepositoryMock!
    var coordinatorMock: CoordinatorMock!
    var viewMock: UserListViewMock!
    var sut: UserListPresenter!
    
    override func setUpWithError() throws {
        userRepositoryMock = UserRepositoryMock()
        coordinatorMock = CoordinatorMock()
        viewMock = UserListViewMock()
        sut = UserListPresenter(userRepository: userRepositoryMock, coordinator: coordinatorMock)
        sut.loadView(view: viewMock!)
    }
    
    override func tearDownWithError() throws {
        userRepositoryMock = nil
        coordinatorMock = nil
        viewMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_fetchUsers_successful_without_data() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        
        //Act
        sut.fetchUsers()
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(viewMock.spyStartLoading, "Show Loading is called")
        XCTAssertTrue(viewMock.spyStopLoading, "Hide Loading is called")
        XCTAssertTrue(viewMock.spySetUsers, "Set data in view is called")
        XCTAssertTrue(viewMock.userListVM.users.isEmpty, "Should be and Array empty")
    }
    
    func test_fetchUsers_successful_with_data() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.filename = filename

        //Act
        sut.fetchUsers()
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(viewMock.spyStartLoading, "Show Loading is called")
        XCTAssertTrue(viewMock.spyStopLoading, "Hide Loading is called")
        XCTAssertTrue(viewMock.spySetUsers, "Set data in view is called")
        XCTAssertFalse(viewMock.userListVM.users.isEmpty, "Should not be an empty array")
    }
    
    func test_fetchUsers_failure_error() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.throwError = .unspecified
        
        //Act
        sut.fetchUsers()
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(viewMock.spyStartLoading, "Show Loading is called")
        XCTAssertTrue(viewMock.spyStopLoading, "Hide Loading is called")
        XCTAssertTrue(viewMock.spyHandleError, "handleError in view is called")
        XCTAssertTrue(viewMock.userListVM.users.isEmpty, "Should be an empty array")
        
        XCTAssertFalse(viewMock.spySetUsers, "Set data in view is called")
    }
    
    func test_navigateToUserDetails() {
        //Arrange
        let user = User()
        
        //Act
        sut.navigateToUserDetails(user: user)
        
        //Assert
        XCTAssertTrue(coordinatorMock.spyNavigateToUserDetails, "Navigate to UserDetails is called")
    }
}
