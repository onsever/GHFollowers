//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-28.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = String(describing: FollowerCell.self)
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function is called by the collection view when it needs to reuse a cell.
    func set(follower: Follower) {
        self.usernameLabel.text = follower.login
        self.avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.avatarImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor),
            
            self.usernameLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 12),
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.usernameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
