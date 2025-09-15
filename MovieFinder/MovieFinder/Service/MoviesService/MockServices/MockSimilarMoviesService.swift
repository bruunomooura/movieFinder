//
//  MockSimilarMoviesService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class MockSimilarMoviesService: SimilarMoviesServiceProtocol {
    var result: Result<MovieResponse, Error>
    
    init(result: Result<MovieResponse, Error>) {
        self.result = result
    }
    
    convenience init() {
        do {
            let similarMovies = try DefaultJSONMockLoader().load(
                JSONFile.similarMovies.rawValue,
                as: MovieResponse.self)
            self.init(result: .success(similarMovies))
        } catch {
            self.init(result: .failure(error))
        }
    }
    
    public func fetchRelatedMovies(movieId: Int, language: String) async throws -> MovieResponse {
        return try result.get()
    }
}
