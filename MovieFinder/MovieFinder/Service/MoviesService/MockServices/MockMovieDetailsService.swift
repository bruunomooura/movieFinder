//
//  MockMovieDetailsService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class MockMovieDetailsService: MovieDetailsServiceProtocol {
    private let decoderService: JSONDecoderService
    
    init(decoderService: JSONDecoderService = JSONDecoderService()) {
        self.decoderService = decoderService
    }
    
    /// Fetches movie details from a local JSON file for testing or mocking purposes.
    ///
    /// - Parameters:
    ///   - movieId: An integer representing the unique identifier of the movie (not used in this implementation).
    ///   - language: A string representing the language for the movie details (not used in this implementation).
    /// - Returns: A `Movie` object containing the fetched movie details.
    /// - Throws: An error of type `MoviesLoadingError` if the JSON file cannot be found or if an error occurs during data loading or decoding.
    func fetchMovieDetails(movieId: Int, language: String) async throws -> Movie {
        guard let url = Bundle.main.url(forResource: JSONFile.movieDetailsData.rawValue, withExtension: JSONFile.json.rawValue) else {
            throw MoviesLoadingError.errorReceivingData
        }
        
        do {
            let data = try Data(contentsOf: url)
            let movies: Movie = try decoderService.decode(Movie.self, from: data)
            return movies
        } catch {
            print("Error: \(error.localizedDescription)")
            throw MoviesLoadingError.errorReceivingData
        }
    }
}
