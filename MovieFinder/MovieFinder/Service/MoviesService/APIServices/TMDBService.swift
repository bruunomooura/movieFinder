//
//  TMDBService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

class TMDBService {
    let session: URLSession
    let decoderService: JSONDecoderService
    
    init(session: URLSession = .shared, decoderService: JSONDecoderService = JSONDecoderService()) {
        self.session = session
        self.decoderService = decoderService
    }
    
    /// Performs an asynchronous network request and decodes the response into a specified type.
    ///
    /// - Parameter url: The URL to which the request is sent.
    /// - Returns: A decoded object of type `T`, where `T` conforms to `Decodable`.
    /// - Throws: An error of type `MoviesLoadingError` if the request fails, or an error if decoding fails.
    func performRequest<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(APIKeys.tmdbAPIToken)"
        ]
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw MoviesLoadingError.errorReceivingData }
        
        do {
            return try decoderService.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}

// Enum that represents the possible errors that may occur when loading an image
enum MoviesLoadingError: Swift.Error {
    case errorReceivingData
}
