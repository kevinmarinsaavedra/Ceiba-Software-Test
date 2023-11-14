//
//  UserDetailsPresenter.swift
//  Ceiba-Software-Challenge
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
        
        self.view?.startLoading()
        
        let parameter = PostParameters(userId: userId)        
        
        postRepository.fetchPosts(parameters: parameter) { [self] (result) in
            
            view?.stopLoading()

            switch result {
            case .success(let posts):
                view?.setPosts(posts: posts)
            case .failure(let error):
                let error = ErrorModel(title: error.title,description: error.description)
                view?.handleError(error: error)
            }
        }
    }
}
