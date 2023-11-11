//
//  UserListViewController.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 2/11/23.
//

import XCTest
import UIKit
@testable import Ceiba_Software_Challenge

class UserListViewControllerTests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    let filename = "Users"
    
    var userRepositoryMock: UserRepositoryMock!
    var userListPresenterMock: UserListPresenterMock!
    var sut: UserListViewController!
    
    override func setUpWithError() throws {
        userRepositoryMock = UserRepositoryMock()
        userListPresenterMock = UserListPresenterMock(userRepository: userRepositoryMock)
        sut = UserListViewController(presenter: userListPresenterMock)
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        userListPresenterMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_navigationBar_with_info() throws {
        //Arrange
        let expectedTitle = "Lista de Contactos"
        let expectedBackButtonTitle = "Atras"
        let searchBarPlaceHolderExpected = "Buscar usuario"

        let searchBar = sut.navigationItem.searchController!.searchBar
        let navigationItem = sut.navigationItem
        
        //Act
        
        //Assert
        XCTAssertEqual(navigationItem.title, expectedTitle,
                       "The navigation bar title should be '\(expectedTitle)'")
        XCTAssertEqual(navigationItem.backBarButtonItem?.title, expectedBackButtonTitle,
                       "The back button title should be '\(expectedBackButtonTitle)'")
        XCTAssertEqual(searchBar.placeholder, searchBarPlaceHolderExpected,
                       "The search bar placeholder should be '\(searchBarPlaceHolderExpected)'")
    }
    
    func test_tableView_empty() throws {
        // Arrange
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let tableViewBackgroundTitleExpected = "No hay usuarios"
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        //Act
        sut.viewWillAppear(true)
        
        // Assert
        XCTAssertTrue(userListPresenterMock.spyFetchUsers, "It should be called findUsers()")
        XCTAssertTrue(sut.userListVM.users.isEmpty, "It should be an empty array")
        XCTAssertTrue(sut.userListVM.usersFilter.isEmpty, "It should be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        if let label = tableView.backgroundView as? UILabel {
            XCTAssertEqual(label.text, tableViewBackgroundTitleExpected)
        } else {
            XCTFail("Background view is not a UILabel")
        }
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected,
                       "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_and_searching_without_result() throws {
        // Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.filename = filename
        
        let searchBar = sut.navigationItem.searchController!.searchBar
        searchBar.text = "Kevin"
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        
        // Act
        sut.viewWillAppear(true)
        searchBar.delegate?.searchBar!(searchBar, textDidChange: searchBar.text!)
        awaitExpAsync()
        
        // Assert
        XCTAssertTrue(userListPresenterMock.spyFetchUsers, "It should be called Find Users function")
        XCTAssertFalse(sut.userListVM.users.isEmpty, "It should not be an empty array for the total users.")
        XCTAssertTrue(sut.userListVM.usersFilter.isEmpty, "It should be an empty array for the filtered users.")

        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected,
                       "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_and_searching_with_result() throws {
        // Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.filename = filename
        
        let searchBar = sut.navigationItem.searchController!.searchBar
        searchBar.text = "David"
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 1
        
        // Act
        sut.viewWillAppear(true)
        searchBar.delegate?.searchBar!(searchBar, textDidChange: searchBar.text!)
        awaitExpAsync()
        
        // Assert
        XCTAssertTrue(userListPresenterMock.spyFetchUsers, "It should be called Find Users function")
        XCTAssertFalse(sut.userListVM.users.isEmpty, "It should not be an empty array for the total users.")
        XCTAssertFalse(sut.userListVM.usersFilter.isEmpty, "It should not be an empty array for the filtered users.")

        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_with_data() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.filename = filename
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 7
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userListPresenterMock.spyFetchUsers, "It should be called findUsers()")
        XCTAssertFalse(sut.userListVM.users.isEmpty, "It should not be an empty array")
        XCTAssertFalse(sut.userListVM.usersFilter.isEmpty, "It should not be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_with_error() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.throwError = .unspecified
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userListPresenterMock.spyFetchUsers, "It should be called findUsers()")
        XCTAssertTrue(sut.userListVM.users.isEmpty, "It should be an empty array")
        XCTAssertTrue(sut.userListVM.usersFilter.isEmpty, "It should be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_with_error_parameters() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.throwError = .parameters
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userListPresenterMock.spyFetchUsers, "It should be called findUsers()")
        XCTAssertTrue(sut.userListVM.users.isEmpty, "It should be an empty array")
        XCTAssertTrue(sut.userListVM.usersFilter.isEmpty, "It should be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    // Cell
    
    func test_tableView_UserListTableViewCell_info() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.filename = filename
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let itemDefault = 0
        let cellCornerRadiusExpected: CGFloat = 10
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        guard let cell = tableView.cellForRow(at: IndexPath(item: itemDefault, section: sectionDefault)) as? UserListTableViewCell else {
            XCTFail("It should be an UserListTableViewCell")
            return
        }
        
        XCTAssertFalse(cell.nameLabel.text!.isEmpty, "The name label should not be empty")
        XCTAssertFalse(cell.phoneLabel.text!.isEmpty, "The phone label should not be empty")
        XCTAssertFalse(cell.emailLabel.text!.isEmpty, "The email label should not be empty")
        XCTAssertEqual(cell.containerView.layer.cornerRadius, cellCornerRadiusExpected, "The corner radius of the containerView should be \(cellCornerRadiusExpected)")
    }
    
    func test_tableView_UserListTableViewCell_goToMyPosts() throws {
        // Arrange
        expAsync = expectation(description: "waiting for data")
        userRepositoryMock.filename = filename
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let itemDefault = 0
        
        // Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        guard let cell = tableView.cellForRow(at: IndexPath(item: itemDefault, section: sectionDefault)) as? UserListTableViewCell else {
            XCTFail("The cell should be of type UserListTableViewCell")
            return
        }

        let seePostsButton = try XCTUnwrap(cell.seePostsButton, "Optional seePostsButton should not be nil")
        seePostsButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(userListPresenterMock.spyNavigateToUserDetails, "Navigate to UserDetails should be called")
    }
}
