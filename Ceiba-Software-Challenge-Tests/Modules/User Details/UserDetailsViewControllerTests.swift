//
//  UserDetailsViewControllerTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 13/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class UserDetailsViewControllerTests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    let filename = "Posts"
    
    var userMock: User!
    var postRepositoryMock: PostRepositoryMock!
    var userDetailsPresenterMock: UserDetailsPresenterMock!
    var sut: UserDetailsViewController!
    
    override func setUpWithError() throws {
        userMock = User(id:nil, name: "Gabriel Guevara")
        postRepositoryMock = PostRepositoryMock()
        userDetailsPresenterMock = UserDetailsPresenterMock(postRepository: postRepositoryMock)
        sut = UserDetailsViewController(presenter: userDetailsPresenterMock, user: userMock)
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        postRepositoryMock = nil
        userDetailsPresenterMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_navigationBar_with_info() throws {
        //Arrange
        let expectedTitle = userMock.name!
        let navigationItem = sut.navigationItem
        
        //Act
            
        //Assert
        XCTAssertEqual(navigationItem.title, expectedTitle, "The navigation bar title should be '\(expectedTitle)'")
    }
    
    func test_tableView_empty() throws {
        // Arrange
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        
        //Act
        sut.viewWillAppear(true)
        
        // Assert
        XCTAssertTrue(userDetailsPresenterMock.spyFetchPosts, "It should be called fetchPosts()")
        XCTAssertTrue(sut.userDetailsVM.posts.isEmpty, "It should be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_with_data() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        postRepositoryMock.filename = filename
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 10
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(postRepositoryMock.spyFetchPosts)
        XCTAssertTrue(userDetailsPresenterMock.spyFetchPosts, "It should be called fetchPosts()")
        XCTAssertFalse(sut.userDetailsVM.posts.isEmpty, "It should not be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    // Cell
    
    func test_tableView_UserDetailsTableViewCell_info() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        postRepositoryMock.filename = filename
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let itemDefault = 0
        let cellCornerRadiusExpected: CGFloat = 10
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        guard let cell = tableView.cellForRow(at: IndexPath(item: itemDefault, section: sectionDefault)) as? UserDetailsTableViewCell else {
            XCTFail("It should be an UserListTableViewCell")
            return
        }
        
        XCTAssertFalse(cell.title.text!.isEmpty, "The name label should not be empty")
        XCTAssertFalse(cell.body.text!.isEmpty, "The phone label should not be empty")
        XCTAssertEqual(cell.containerView.layer.cornerRadius, cellCornerRadiusExpected, "The corner radius of the containerView should be \(cellCornerRadiusExpected)")
    }
    
    func test_tableView_with_error() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        postRepositoryMock.throwError = .unspecified
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userDetailsPresenterMock.spyFetchPosts, "It should be called fetchPosts()")
        XCTAssertTrue(sut.userDetailsVM.posts.isEmpty, "It should be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_with_error_parameters() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        postRepositoryMock.throwError = .parameters
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userDetailsPresenterMock.spyFetchPosts, "It should be called fetchPosts()")
        XCTAssertTrue(sut.userDetailsVM.posts.isEmpty, "It should be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
    
    func test_tableView_with_error_parse() throws {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        
        postRepositoryMock.throwError = .parse(description: "Test error description")
        
        let tableView = try XCTUnwrap(sut.tableView, "Optional tableView should not be nil")
        let sectionDefault = 0
        let numberOfRowsExpected = 0
        
        //Act
        sut.viewWillAppear(true)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(userDetailsPresenterMock.spyFetchPosts, "It should be called fetchPosts()")
        XCTAssertTrue(sut.userDetailsVM.posts.isEmpty, "It should be an empty array")
        
        XCTAssertNotNil(tableView, "It shouls not be nil")
        
        let numberOfRows = tableView.numberOfRows(inSection: sectionDefault)
        XCTAssertEqual(numberOfRows, numberOfRowsExpected, "Number of rows in the tableView should be \(numberOfRowsExpected))")
    }
}
