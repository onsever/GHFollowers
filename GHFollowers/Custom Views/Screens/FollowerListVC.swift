//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import UIKit

class FollowerListVC: UIViewController {
    
    // Section is an enum that we created below. It will be used to identify the section of the collection view. (The reason we used enums are that they are hashable by default.)
    enum Section {
        case main
    }
    
    var username: String!
    private var followers: [Follower] = []
    private var page: Int = 1
    private var hasMoreFollowers: Bool = true
    
    private var collectionView: UICollectionView!
    // Compared to UICollectionViewDataSource, instead of indexPath, it uses hash values (unique ids) to compare the snapshots.
    // It takes two parameters, first one is the type of the object that we want to display, second one is the type of the object that we want to use to identify the object. Both should conform to Hashable protocol.
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewController()
        self.configureCollectionView()
        self.getFollowers(username: self.username, page: self.page)
        self.configureDataSource()
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
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createThreeColumnLayout(in: self.view))
        self.view.addSubview(self.collectionView)
        // Set the delegate.
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .systemBackground
        // Register the cell to the collection view.
        self.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func getFollowers(username: String, page: Int) {
        // Show the loading view.
        self.showLoadingView()
        // NetworkManager has a strong reference to the view controller, so we need to use weak self to avoid memory leaks.)
        // Whenever we use self inside a closure, Swift will automatically create a strong reference to the view controller. (This is called a capture list) -> Capture List: [weak self] - [unowned self] (Force unwrapped)
        // weak self makes optional because it can be nil.
        NetworkManager.shared.getFollowers(for: username, page: self.page) { [weak self] result in
            // Swift 4.2+ | Unwrapping the self.
            guard let self = self else { return }
            
            // Hide the loading view.
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                // Check if we are on the last page.
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                // Update the followers array.
                self.followers.append(contentsOf: followers)
                
                // Check if the followers array is empty and if it is, show the empty state view.
                if self.followers.isEmpty {
                    // Show the empty state view.
                    let message = "This user doesn't have any followers. Go follow them 😃."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                
                // Update the data source. (After making sure that we have the data)
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, follower in
            // Create the cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            // Configure the cell (Sending the follower object to the cell)
            cell.set(follower: follower)
            
            // Return the cell
            return cell
        })
    }
    
    // Feed the data from network request to the collection view.
    // We will use this method to update the data source and apply the snapshot to the collection view.
    private func updateData() {
        // Initialize the snapshot.
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // Add the sections to the snapshot.
        snapshot.appendSections([.main])
        // Add the items (array of followers) to the snapshot.
        snapshot.appendItems(self.followers)
        // Apply the snapshot to the data source. (This will update the collection view)
        // Since we are updating the UI, we need to do it on the main thread.
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

// MARK: - UICollectionViewDelegate (implements scroll view delegate)
extension FollowerListVC: UICollectionViewDelegate {
    
    //This method is called when the user stops dragging the collection view.
    // We use it to check if we need to load the next set of followers when reaching the bottom.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // We will check if we are at the bottom of the collection view.
        // Capture the vertical offset of the content within the scroll view.
        let offsetY = scrollView.contentOffset.y
        // Determine the total height of the scrollable content, including the hidden content.
        let contentHeight = scrollView.contentSize.height
        // Get the height of the visible portion of the scroll view on the screen.
        let height = scrollView.frame.size.height
        
        print("offsetY: \(offsetY)")
        print("contentHeight: \(contentHeight)")
        print("height: \(height)")
        
        // If we are at the bottom of the collection view, load next 100 followers if available.
        if offsetY > contentHeight - height {
            // Make sure that we have more followers to load.
            guard hasMoreFollowers else { return }
            // Increase the page number.
            self.page += 1
            // Load the next 100 followers.
            self.getFollowers(username: self.username, page: self.page)
        }
    }
    
}
