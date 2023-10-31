//
//  UserDetailsViewController.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 16/9/21.
//

import UIKit

protocol UserDetailsViewDelegate: UIViewController {
    func starLoading()
    func stopLoading()
    func setPosts(posts: [Post.Model])
}

final class UserDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private struct Constants {
        static let nibNameCell = "UserDetailsTableViewCell"
    }
    
    let presenter: UserDetailsPresenterProtocol
    let user: User
    var posts: [Post.Model] = []
    
    init(presenter: UserDetailsPresenterProtocol, user: User) {
        self.user = user
        self.presenter = presenter
        super.init(nibName: "UserDetailsViewController", bundle: nil)
        self.presenter.loadView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.fetchPosts(byUserId: user.id)
    }
    
    private func setupView(){
        self.navigationItem.title = user.name ?? ""
    }
    
    private func setupTableView() {
        let nibNameCell = UINib(nibName: Constants.nibNameCell, bundle: nil)
        tableView.register(nibNameCell, forCellReuseIdentifier: UserDetailsTableViewCell.reuseIdentifier)
    }
}

extension UserDetailsViewController: UserDetailsViewDelegate {
    
    func starLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setPosts(posts: [Post.Model]) {
        self.posts = posts
        tableView.reloadData()
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsTableViewCell.reuseIdentifier, for: indexPath) as? UserDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(post: posts[indexPath.row])
        
        return cell
    }
}
