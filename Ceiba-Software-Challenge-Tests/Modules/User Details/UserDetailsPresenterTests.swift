//
//  UserDetailsPresenterTests.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 11/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class UserDetailsPresenterTests: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    let filename = "Posts"
    
    var postRepositorMock: PostRepositoryMock!
    var viewMock: UserDetailsViewMock!
    var sut: UserDetailsPresenter!
    
    override func setUpWithError() throws {
        postRepositorMock = PostRepositoryMock()
        viewMock = UserDetailsViewMock()
        sut = UserDetailsPresenter(postRepository: postRepositorMock)
        sut.loadView(view: viewMock)
    }
    
    override func tearDownWithError() throws {
        postRepositorMock = nil
        viewMock = nil
        sut = nil
        expAsync = nil
    }
    
    func test_fecthPosts_successful_without_data() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        
        //Act
        sut.fetchPosts(byUserId: nil)
        awaitExpAsync()

        //Assert
        XCTAssertTrue(viewMock.spyStartLoading, "Show loading is called")
        XCTAssertTrue(viewMock.spyStopLoading, "Hiddin loading is called")
        XCTAssertTrue(viewMock.spySetPosts, "Set data in view is called")
        XCTAssertTrue(viewMock.userDetailsVM.posts.isEmpty, "Should be an array empty")

    }
    
    func test_fecthPosts_successful_with_data() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        postRepositorMock.filename = filename
        
        //Act
        sut.fetchPosts(byUserId: nil)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(viewMock.spyStartLoading, "Show loading is called")
        XCTAssertTrue(viewMock.spyStopLoading, "Hiddin loadin is called")
        XCTAssertTrue(viewMock.spySetPosts, "Set data in view is called")
        XCTAssertFalse(viewMock.userDetailsVM.posts.isEmpty, "Should not be an array empty")
        
    }
    
    func test_fecthPosts_failure_error_unspecified() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        postRepositorMock.throwError = .unspecified
        
        //Act
        sut.fetchPosts(byUserId: nil)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(viewMock.spyStartLoading, "Show loading is called")
        XCTAssertTrue(viewMock.spyStopLoading, "Hidden loading is called")
        XCTAssertTrue(viewMock.spyHandleError, "handleError in view is called")
        XCTAssertTrue(viewMock.userDetailsVM.posts.isEmpty, "Should be an array empty")
        
        XCTAssertFalse(viewMock.spySetPosts, "Set data in view is called")
    }
    
    func test_fecthPosts_failure_error_parameters() {
        //Arrange
        expAsync = expectation(description: "waiting for data")
        postRepositorMock.throwError = .unspecified
        
        //Act
        sut.fetchPosts(byUserId: nil)
        awaitExpAsync()
        
        //Assert
        XCTAssertTrue(viewMock.spyStartLoading, "Show loading is called")
        XCTAssertTrue(viewMock.spyStopLoading, "Hidden loading is called")
        XCTAssertTrue(viewMock.spyHandleError, "handleError in view is called")
        XCTAssertTrue(viewMock.userDetailsVM.posts.isEmpty)
        
        XCTAssertFalse(viewMock.spySetPosts, "Set data in view is called")
    }
}
