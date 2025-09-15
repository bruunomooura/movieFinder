//
//  NetworkError.swift
//  MovieFinder
//
//  Created by Bruno Moura on 04/09/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case noInternet
    case timeout
    case invalidURL
    case urlComponentCreationFailed
    case serverError(code: Int)
    case decodingError
    case unknown(description: String)
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection."
        case .timeout:
            return "The request timed out."
        case .invalidURL:
            return "Invalid URL."
        case .urlComponentCreationFailed:
            return "Failed to construct URL with components."
        case .serverError(let code):
            return "Server error (\(code))."
        case .decodingError:
            return "Failed to decode mock file."
        case .unknown(let description):
            return description
        }
    }
}
