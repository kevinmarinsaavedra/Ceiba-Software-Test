//
//  UserDetailsTableViewCell.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 19/9/21.
//

import UIKit

final class UserDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    static let reuseIdentifier = "UserDetailsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.setNeedsLayout()
    }
    
    func configureCell(post: Post.Model) {
        title.text = post.title
        body.text = post.body
    }
}
