//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-29.
//

import UIKit

class GFEmptyStateView: UIView {
    
    private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        configure()
    }
    
    private func configure() {
        self.addSubview(messageLabel)
        self.addSubview(logoImageView)
        
        self.messageLabel.numberOfLines = 3
        self.messageLabel.textColor = .secondaryLabel
        
        self.logoImageView.image = UIImage(named: "empty-state-logo")
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            // Make image 30% bigger than the screen width.
            self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            self.logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }

}
