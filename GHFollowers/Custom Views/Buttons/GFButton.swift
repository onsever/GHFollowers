//
//  GFButton.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.configure()
    }
    
    private func configure() {
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        // Setting the font that scales to the user's desired font size.
        self.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
