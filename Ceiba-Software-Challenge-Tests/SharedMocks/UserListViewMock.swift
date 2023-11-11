//
//  UserListViewMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 31/10/23.
//

import UIKit
@testable import Ceiba_Software_Challenge
import XCTest

class UserListViewMock: UIViewController, UserListViewDelegate {
    
    var userListVM: UserList.ViewModel = UserList.ViewModel()
    var spyStarLoading: Bool = false
    var spyStopLoading: Bool = false
    var spyHandleError: Bool = false
    var spySetUsers: Bool = false
    
    func starLoading() {
        spyStarLoading = true
    }
    
    func stopLoading() {
        spyStopLoading = true
    }
    
    func handleError(error: ErrorModel?) {
        spyHandleError = true
    }
    
    func setUser(users: [User]) {
        spySetUsers = true
        userListVM.users = users
    }
}
