//
//  UserDetailsViewMock.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 11/11/23.
//

import UIKit
@testable import Ceiba_Software_Challenge

class UserDetailsViewMock: UIViewController, UserDetailsViewDelegate {
    var userDetailsVM: UserDetails.ViewModel = .init()
    var spyStartLoading: Bool = false
    var spyStopLoading: Bool = false
    var spyHandleError: Bool = false
    var spySetPosts: Bool = false
    
    func startLoading() {
        spyStartLoading = true
    }
    
    func stopLoading() {
        spyStopLoading = true
    }
    
    func handleError(error: Ceiba_Software_Challenge.ErrorModel?) {
        spyHandleError = true
    }
    
    func setPosts(posts: [Post]) {
        spySetPosts = true
        userDetailsVM.posts = posts
    }
}
