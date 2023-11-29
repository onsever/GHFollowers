//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewController()
        self.configureCollectionView()
        self.getFollowers()
    }
    
    // BUG Fix: Whenever we swipe back half way to the previous screen, navigation bar gets disappears. To fix this, we will move this logic to viewWillAppear().
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Unlike self.navigationController?.navigationBar.isHidden = false, this method animates the navigation bar.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        // Initialize the collection view.
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.createThreeColumnLayout())
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .systemPink
        // Register the cell to the collection view.
        self.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func createThreeColumnLayout() -> UICollectionViewFlowLayout {
        // Get the width of the device.
        let width = self.view.bounds.width
        // Set the padding and minimum item spacing.
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        // (padding * 2) -> left and right padding from the super view.
        // (padding) [] - [] - [] (padding)
        // (minimumItemSpacing * 2) -> since it's three grid layout, there will be total of two spaces between the cell. [] - [] - []
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        // Divide the available width by 3 to get the width of each cell.
        let itemWidth = availableWidth / 3
        // Initialize the layout. (How the cells will be displayed)
        let flowLayout = UICollectionViewFlowLayout()
        // Set the section inset. (padding)
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        // Set the item size. (Square avatar + 40 is for the username label)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
}
