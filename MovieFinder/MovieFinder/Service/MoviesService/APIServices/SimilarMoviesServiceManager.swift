//
//  SimilarMoviesServiceManager.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class SimilarMoviesServiceManager: TMDBService, SimilarMoviesServiceProtocol {
    func fetchRelatedMovies(movieId: Int, language: String) async throws -> MovieResponse {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/similar") else {
            throw NetworkError.invalidURL
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkError.invalidURL
        }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        components.queryItems = queryItems
        
        return try await performRequest(url: components.url ?? url)
    }
}
