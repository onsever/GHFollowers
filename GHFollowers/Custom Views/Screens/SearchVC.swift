//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-26.
//

import UIKit

class SearchVC: UIViewController {
    
    private let logoImageView = UIImageView()
    private let usernameTextField = GFTextField()
    private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    private var isUsernameEntered: Bool {
        return !self.usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.configureLogoImageView()
        self.configureTextField()
        self.configureCallToActionButton()
        self.createDismissKeyboardTapGesture()
    }
    
    // Hiding the navigation bar. (viewDidLoad doesn't get called when we go back in the navigation stack, but viewWillAppear gets called.)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // Whenever we click somewhere on the super view, we will dismiss the keyboard.
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    // Pushing the navigation to the FollowerListVC.
    @objc private func pushFollowerListVC() {
        guard self.isUsernameEntered else {
            self.presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        
        let followerListVC = FollowerListVC()
        followerListVC.username = self.usernameTextField.text
        followerListVC.title = self.usernameTextField.text
        self.navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    private func configureLogoImageView() {
        self.view.addSubview(self.logoImageView)
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.image = UIImage(named: "gh-logo")!
        
        // 4 constraints: height, width, x, y
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField() {
        self.view.addSubview(self.usernameTextField)
        // View controller should listen to UITextField's delegate to take an action.
        self.usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            self.usernameTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 48),
            self.usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCallToActionButton() {
        self.view.addSubview(callToActionButton)
        self.callToActionButton.addTarget(self, action: #selector(self.pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.callToActionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            self.callToActionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.callToActionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            self.callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

// To respond to the return key press, we need to use UITextFieldDelegate.
extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // This method gets called whenever we tap on the return key.
        pushFollowerListVC()
        return true
    }
    
}
