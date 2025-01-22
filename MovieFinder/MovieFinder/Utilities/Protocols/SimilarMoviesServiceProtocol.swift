//
//  SimilarMoviesServiceProtocol.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

protocol SimilarMoviesServiceProtocol {
    func fetchRelatedMovies(movieId: Int, language: String) async throws -> MovieResponse
}
