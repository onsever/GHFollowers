//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-28.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let cache = NetworkManager.shared.cache
    private let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    // This initializer is needed when we create this view programmatically.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.layer.cornerRadius = 10
        // This is needed to make sure that the image is not stretched.
        self.clipsToBounds = true
        self.image = placeholderImage
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // This method is getting called everytime when GFAvatarImageView is initialized for the UICollectionViewCell. (Cell appears on the screen.)
    func downloadImage(from urlString: String) {
        // Before making a network call to download the image for each user, we check if the image is already in the cache.
        let cacheKey = NSString(string: urlString)
        
        if let image = self.cache.object(forKey: cacheKey) {
            // We have the image in the cache.
            self.image = image
            return
        }
        
        // We don't have the image in the cache.
        
        // Convert the urlString to URL.
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            // Add the image to the cache.
            self.cache.setObject(image, forKey: cacheKey)
            
            // We are on the background thread. This is needed to update the UI on the main thread.
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        // Start the network call.
        task.resume()
    }
    
}
