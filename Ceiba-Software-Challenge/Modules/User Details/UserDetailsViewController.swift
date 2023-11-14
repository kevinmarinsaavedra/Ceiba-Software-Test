//
//  UserDetailsViewController.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 16/9/21.
//

import UIKit

protocol UserDetailsViewDelegate: UIViewController {
    func startLoading()
    func stopLoading()
    func handleError(error: ErrorModel?)
    func setPosts(posts: [Post])
}

final class UserDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private struct Constants {
        static let nibNameCell = "UserDetailsTableViewCell"
    }
    
    let presenter: UserDetailsPresenterProtocol
    
    var userDetailsVM = UserDetails.ViewModel()
    
    init(presenter: UserDetailsPresenterProtocol, user: User) {
        self.userDetailsVM.user = user
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
        presenter.fetchPosts(byUserId: userDetailsVM.user.id)
    }
    
    private func setupView(){
        self.navigationItem.title = userDetailsVM.user.name ?? ""
    }
    
    private func setupTableView() {
        let nibNameCell = UINib(nibName: Constants.nibNameCell, bundle: nil)
        tableView.register(nibNameCell, forCellReuseIdentifier: UserDetailsTableViewCell.reuseIdentifier)
    }
}

extension UserDetailsViewController: UserDetailsViewDelegate {
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func handleError(error: ErrorModel?) {
        guard let error else { return}
        
        print(error.title, error.description)
    }
    
    func setPosts(posts: [Post]) {
        self.userDetailsVM.posts = posts
        tableView.reloadData()
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailsVM.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsTableViewCell.reuseIdentifier, for: indexPath) as? UserDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(post: userDetailsVM.posts[indexPath.row])
        
        return cell
    }
}
