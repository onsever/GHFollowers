//
//  Follower.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import Foundation

// Codable -> Decodable (decoding JSON to the Swift object) & Encodable (encode Swift object to JSON) -> JSONDecoder & JSONEncoder
struct Follower: Codable {
    var login: String
    // JSONDecoder - keyDecodingStrategy: converted from snake_case to camelCase (.convertFromSnakeCase)
    var avatarUrl: String
}
