//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    // This is a cache that stores images in memory. Cache will improve the performance as well as prevents the app from downloading the same image over and over again. (We only want single instance of the cache.)
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    /*
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        // Check if the URL is valid
        guard let url = URL(string: endpoint) else {
            // If url is invalid, return nil and error message
            completed(nil, .invalidUsername)
            return
        }
        
        // Create a URL session
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                // If error is not nil, return nil and error message
                completed(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // If response is not 200, return nil and error message
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                // If data is nil, return nil and error message
                completed(nil, .invalidData)
                return
            }
            
            // If everything is fine, decode the data
            do {
                // Decode the JSON data into Swift objects
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // Convert the data into an array of followers
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                // Catch the errors from try.
                completed(nil, .invalidData)
            }
        }
        
        // Start the task (request)
        task.resume()
    }
     */
    
    // MARK: - Result type refactoring (Swift 5)
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        // Check if the URL is valid
        guard let url = URL(string: endpoint) else {
            // If url is invalid, return nil and error message
            completed(.failure(.invalidUsername))
            return
        }
        
        // Create a URL session
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                // If error is not nil, return nil and error message
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // If response is not 200, return nil and error message
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                // If data is nil, return nil and error message
                completed(.failure(.invalidData))
                return
            }
            
            // If everything is fine, decode the data
            do {
                // Decode the JSON data into Swift objects
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // Convert the data into an array of followers
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                // Catch the errors from try.
                completed(.failure(.invalidData))
            }
        }
        
        // Start the task (request)
        task.resume()
    }
}
