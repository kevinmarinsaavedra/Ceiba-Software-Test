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
        self.view?.starLoading()
        
        userRepository.fetchUser { result in
            
            self.view?.stopLoading()
            
            switch result {
            case .success(let users):
                self.view?.setUser(users: users)
            case .failure(_):
                return
            }
        }
    }
    
    func navigateToUserDetails(user: User) {
        coordinator.navigate(.userDetails(user: user))
    }
}
