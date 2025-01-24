//
//  SimilarMoviesServiceManager.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class SimilarMoviesServiceManager: TMDBService, SimilarMoviesServiceProtocol {
    /// Fetches a list of movies related to a specified movie from the API.
    ///
    /// - Parameters:
    ///   - movieId: An integer representing the unique identifier of the movie for which similar movies are to be fetched.
    ///   - language: A string representing the language for the related movie details.
    /// - Returns: A `MovieResponse` object containing the fetched related movies.
    /// - Throws: An error of type `MoviesLoadingError` if the URL is invalid or if an error occurs during the request.
    func fetchRelatedMovies(movieId: Int, language: String) async throws -> MovieResponse {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/similar") else { throw MoviesLoadingError.errorReceivingData }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw MoviesLoadingError.errorReceivingData }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        components.queryItems = queryItems
        
        return try await performRequest(url: components.url ?? url)
    }
}
