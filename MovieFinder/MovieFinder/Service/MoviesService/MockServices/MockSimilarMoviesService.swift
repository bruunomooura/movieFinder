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
