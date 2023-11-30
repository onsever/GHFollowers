//
//  Follower.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import Foundation

// Codable -> Decodable (decoding JSON to the Swift object) & Encodable (encode Swift object to JSON) -> JSONDecoder & JSONEncoder
// As long as the types we are using Hashable, we don't need to type hash function.
// We can only specify specific properties and make them hashable to improve performance.
struct Follower: Codable, Hashable {
    var login: String
    // JSONDecoder - keyDecodingStrategy: converted from snake_case to camelCase (.convertFromSnakeCase)
    var avatarUrl: String
}
