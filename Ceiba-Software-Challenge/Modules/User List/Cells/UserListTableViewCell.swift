//
//  UserListTableViewCell.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation
import UIKit

protocol userListTableViewCellDelegate: AnyObject {
    func goToMyPosts(user: User)
}

final class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var seePostsButton: UIButton!
    
    static let reuseIdentifier = "UserListTableViewCell"
    var user: User?
    weak var delegate: userListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.setNeedsLayout()
    }
    
    func configureCell(user: User) {
        self.user = user
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
    
    @IBAction func goToMyPosts() {
        guard let user = user else { return }
        delegate?.goToMyPosts(user: user)
    }
}
