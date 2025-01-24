//
//  MovieDetailsServiceManager.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class MovieDetailsServiceManager: TMDBService, MovieDetailsServiceProtocol {
    /// Fetches the details of a movie from the API.
    ///
    /// - Parameters:
    ///   - movieId: An integer representing the unique identifier of the movie.
    ///   - language: A string representing the language for the movie details.
    /// - Returns: A `Movie` object containing the fetched movie details.
    /// - Throws: An error of type `MoviesLoadingError` if the URL is invalid or if an error occurs during the request.
    func fetchMovieDetails(movieId: Int, language: String) async throws -> Movie {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)") else { throw MoviesLoadingError.errorReceivingData }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw MoviesLoadingError.errorReceivingData }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: language),
        ]
        components.queryItems = queryItems
        
        return try await performRequest(url: components.url ?? url)
    }
}
