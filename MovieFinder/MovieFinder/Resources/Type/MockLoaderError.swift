//
//  MockLoaderError.swift
//  MovieFinder
//
//  Created by Bruno Moura on 04/09/25.
//

import Foundation

enum MockLoaderError: Error, LocalizedError {
    case fileNotFound(String)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let filename):
            return "Mock file not found: \(filename).json"
        case .decodingError:
            return "Failed to decode mock file."
        }
    }
}
