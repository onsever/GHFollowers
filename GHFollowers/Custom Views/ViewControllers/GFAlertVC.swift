//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import UIKit

class GFAlertVC: UIViewController {
    
    private let containerView = UIView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    private let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        self.configureBlurEffect()
        self.configureContainerView()
        self.configureTitleLabel()
        self.configureActionButton()
        self.configureMessageLabel()
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configureBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.view.bounds
        blurredEffectView.alpha = 0.75
        self.view.addSubview(blurredEffectView)
    }
    
    private func configureContainerView() {
        self.view.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.backgroundColor = .systemBackground
        self.containerView.layer.cornerRadius = 16
        self.containerView.layer.borderWidth = 2
        self.containerView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.containerView.widthAnchor.constraint(equalToConstant: 280),
            self.containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureTitleLabel() {
        self.containerView.addSubview(self.titleLabel)
        
        self.titleLabel.text = self.alertTitle ?? "Something went wrong!"
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: self.padding),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.padding),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.padding),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureActionButton() {
        self.containerView.addSubview(self.actionButton)
        
        self.actionButton.setTitle(self.buttonTitle ?? "Ok", for: .normal)
        self.actionButton.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.actionButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -self.padding),
            self.actionButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.padding),
            self.actionButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.padding),
            self.actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureMessageLabel() {
        self.containerView.addSubview(self.messageLabel)
        
        self.messageLabel.text = self.message ?? "Unable to complete the request."
        self.messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.padding),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.padding),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.actionButton.topAnchor, constant: -12)
        ])
    }

}
