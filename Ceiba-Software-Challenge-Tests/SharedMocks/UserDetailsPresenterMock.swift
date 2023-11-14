//
//  UserDetailsPresenterMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 13/11/23.
//

import UIKit
@testable import Ceiba_Software_Challenge

class UserDetailsPresenterMock: UserDetailsPresenterProtocol {
    var spyLoadView: Bool = false
    var spyFetchPosts: Bool = false
    
    private let postRepository: PostRepositoryProtocol
    private weak var view: UserDetailsViewDelegate!

    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    
    func loadView(view: UserDetailsViewDelegate) {
        spyLoadView = true
        self.view = view
    }
    
    func fetchPosts(byUserId userId: Int?) {
        spyFetchPosts = true
        
        self.view?.startLoading()
        
        let parameter = PostParameters(userId: userId)
        
        postRepository.fetchPosts(parameters: parameter) { [self] (result) in
            
            view?.stopLoading()

            switch result {
            case .success(let posts):
                view?.setPosts(posts: posts)
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
}
