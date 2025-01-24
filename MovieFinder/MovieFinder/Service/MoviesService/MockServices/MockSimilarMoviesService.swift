//
//  MockSimilarMoviesService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class MockSimilarMoviesService: SimilarMoviesServiceProtocol {
    private let decoderService: JSONDecoderService
    
    init(decoderService: JSONDecoderService = JSONDecoderService()) {
        self.decoderService = decoderService
    }
    
    /// Fetches related movies from a local JSON file for testing or mocking purposes.
    ///
    /// - Parameters:
    ///   - movieId: An integer representing the unique identifier of the movie (not used in this implementation).
    ///   - language: A string representing the language for the related movie details (not used in this implementation).
    /// - Returns: A `MovieResponse` object containing the fetched related movies.
    /// - Throws: An error of type `MoviesLoadingError` if the JSON file cannot be found or if an error occurs during data loading or decoding.
    func fetchRelatedMovies(movieId: Int, language: String) async throws -> MovieResponse {
        guard let url = Bundle.main.url(forResource: JSONFile.similarMovies.rawValue, withExtension: JSONFile.json.rawValue) else { throw MoviesLoadingError.errorReceivingData }
        
        do {
            let data = try Data(contentsOf: url)
            let relatedMovies: MovieResponse = try decoderService.decode(MovieResponse.self, from: data)
            return relatedMovies
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
}
