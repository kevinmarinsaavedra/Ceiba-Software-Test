//
//  UserListPresenterMock.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 2/11/23.
//

import UIKit
@testable import Ceiba_Software_Challenge

class UserListPresenterMock: UserListPresenterProtocol {
    private let userRepository: UserRepositoryProtocol
    private weak var view: UserListViewDelegate!
    
    var spyLoadView: Bool = false
    var spyFetchUsers: Bool = false
    var spyNavigateToUserDetails: Bool = false
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func loadView(view: UserListViewDelegate) {
        spyLoadView = true
        self.view = view
    }
    
    func fetchUsers() {
        spyFetchUsers = true
        self.view?.starLoading()
        
        userRepository.fetchUser { [self] result in
            view.stopLoading()
            
            switch result {
            case .success(let users):
                view.setUser(users: users)
            case .failure(let error):
                switch error {
                    
                case .unspecified:
                    view.handleError(error: nil)
                default:
                    let error = ErrorModel(title: error.title, description: error.description)
                    view.handleError(error: error)
                }
            }
        }
    }
    
    func navigateToUserDetails(user: User) {
        spyNavigateToUserDetails = true
    }
}
