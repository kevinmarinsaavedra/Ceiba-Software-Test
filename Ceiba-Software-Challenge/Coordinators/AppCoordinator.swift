//
//  AppCoordinator.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 16/9/21.
//

import Foundation
import UIKit

enum Route {
    case userDetails(user: User)
}

protocol BaseCoordinator {
    func start() -> UINavigationController
    func navigate(_ router: Route)
}

final class AppCoordinator: BaseCoordinator{

    var navController: UINavigationController?
    
    func start() -> UINavigationController {
        let userService = UserAPI()
        let localDatabaseManager = RealmDataBase()
        let repository = UserRepository(userService: userService, localDatabaseManager: localDatabaseManager)
        let presenter = UserListPresenter(userRepository: repository, coordinator: self)
        let controller = UserListViewController(presenter: presenter)
        
        let navController = UINavigationController(rootViewController: controller)

        self.navController = navController
        
        return navController
    }
    
    func navigate(_ router: Route) {
        switch router {
        case .userDetails(let user):
            let postService = PostAPI()
            let repository = PostRepository(postService: postService)
            let presenter = UserDetailsPresenter(postRepository: repository)
            let controller = UserDetailsViewController(presenter: presenter, user: user)
            
            navController?.pushViewController(controller, animated: true)
        }
    }
    
}
