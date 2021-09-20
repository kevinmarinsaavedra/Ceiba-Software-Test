//
//  UserDetailsPresenter.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 16/9/21.
//

import Foundation

protocol UserDetailsPresenterProtocol {
    func loadView(view: UserDetailsViewDelegate)
    func fetchPosts(byUserId userId: Int?)
}

final class UserDetailsPresenter: UserDetailsPresenterProtocol {

    private let postRepository: PostRepositoryProtocol
    private weak var view: UserDetailsViewDelegate?

    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    
    func loadView(view: UserDetailsViewDelegate) {
        self.view = view
    }
    
    func fetchPosts(byUserId userId: Int?) {
        
        self.view?.starLoading()
        
        let parameter = Post.Parameters(userId: userId)        
        
        postRepository.fetchPosts(parameters: parameter) { (result) in
            
            self.view?.stopLoading()

            switch result {
            case .success(let posts):
                self.view?.setPosts(posts: posts)
            case .failure(_):
                return
            }
        }
    }
}
