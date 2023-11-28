//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-28.
//

import Foundation

// Raw value (one type), Associated value (multiple types)
enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
