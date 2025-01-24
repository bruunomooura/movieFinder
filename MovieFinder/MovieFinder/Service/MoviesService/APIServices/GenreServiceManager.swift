//
//  GenreServiceManager.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class GenreServiceManager: TMDBService, GenreServiceProtocol {
    /// Fetches the genres of movies from the API.
    ///
    /// - Parameter language: A string representing the language for the genre list.
    /// - Returns: A `GenreResponse` object containing the fetched genres.
    /// - Throws: An error of type `MoviesLoadingError` if the URL is invalid or if an error occurs during the request.
    func fetchGenres(language: String) async throws -> GenreResponse {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list") else { throw MoviesLoadingError.errorReceivingData }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw MoviesLoadingError.errorReceivingData }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: language),
        ]
        components.queryItems = queryItems
        
        return try await performRequest(url: components.url ?? url)
    }
}
