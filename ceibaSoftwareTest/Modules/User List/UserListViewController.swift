//
//  UserListViewController.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 16/9/21.
//

import UIKit

protocol UserListViewDelegate: UIViewController {
    func starLoading()
    func stopLoading()
    func setUser(users: [User])
}

final class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        
        search.searchBar.placeholder = "Buscar usuario"
        search.searchBar.backgroundColor = UIColor(hexString: "#3FCB5E")
        search.searchBar.searchTextField.backgroundColor = .white
        search.searchBar.searchTextField.tintColor = .lightGray

        return search
    }()
    
    private struct Constants {
        static let nibNameCell = "UserListTableViewCell"
    }
    
    let presenter: UserListPresenterProtocol
    
    var userListVM = UserList.ViewModel()
    
    init(presenter: UserListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "UserListViewController", bundle: nil)
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
        
        presenter.fetchUsers()
    }
    
    private func setupView(){
        
        
        //back Button
        navigationItem.title = "Lista de Contactos"
        navigationItem.searchController = searchController
        navigationItem.searchController?.automaticallyShowsScopeBar = true
        let backItem = UIBarButtonItem()
            backItem.title = "Atras"
            navigationItem.backBarButtonItem = backItem
        

    }
    
    private func setupTableView() {
        let nibNameCell = UINib(nibName: Constants.nibNameCell, bundle: nil)
        tableView.register(nibNameCell, forCellReuseIdentifier: UserListTableViewCell.reuseIdentifier)
    }
}

extension UserListViewController: UserListViewDelegate {
    func starLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setUser(users: [User]) {
        userListVM.users = users
        tableView.reloadData()
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListVM.usersFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.reuseIdentifier, for: indexPath) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        cell.configureCell(user: userListVM.usersFilter[indexPath.row])
        
        return cell
    }
}

extension UserListViewController: userListTableViewCellDelegate {
    func goToMyPosts(user: User) {
        presenter.navigateToUserDetails(user: user)
    }
}

extension UserListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        userListVM.searchBy = searchController.searchBar.text ?? ""
        
        tableView.reloadData()
    }
}
