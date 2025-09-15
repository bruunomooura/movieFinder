//
//  MockMovieDetailsService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class MockMovieDetailsService: MovieDetailsServiceProtocol {
    var result: Result<Movie, Error>
    
    init(result: Result<Movie, Error>) {
        self.result = result
    }
    
    convenience init() {
        do {
            let movie = try DefaultJSONMockLoader().load(
                JSONFile.movieDetailsData.rawValue,
                as: Movie.self)
            self.init(result: .success(movie))
        } catch {
            self.init(result: .failure(error))
        }
    }
    
    public func fetchMovieDetails(movieId: Int, language: String) async throws -> Movie {
        return try result.get()
    }
}
