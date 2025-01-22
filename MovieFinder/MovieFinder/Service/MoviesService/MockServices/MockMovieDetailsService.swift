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
