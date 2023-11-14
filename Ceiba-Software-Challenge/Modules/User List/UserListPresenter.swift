//
//  UserListPresenter.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 16/9/21.
//

import Foundation

protocol UserListPresenterProtocol {
    func loadView(view: UserListViewDelegate)
    func fetchUsers()
    
    func navigateToUserDetails(user: User)
}

final class UserListPresenter: UserListPresenterProtocol {
    
    private let coordinator: BaseCoordinator
    private let userRepository: UserRepositoryProtocol
    private weak var view: UserListViewDelegate?
    
    init(userRepository: UserRepositoryProtocol, coordinator: BaseCoordinator) {
        self.userRepository = userRepository
        self.coordinator = coordinator
    }
    
    func loadView(view: UserListViewDelegate) {
        self.view = view
    }
    
    func fetchUsers() {
        self.view?.startLoading()
        
        userRepository.fetchUser { [self] result in
            view?.stopLoading()
            
            switch result {
            case .success(let users):
                view?.setUser(users: users)
            case .failure(let error):
                let error = ErrorModel(title: error.title,description: error.description)
                view?.handleError(error: error)
            }
        }
    }
    
    func navigateToUserDetails(user: User) {
        coordinator.navigate(.userDetails(user: user))
    }
}
