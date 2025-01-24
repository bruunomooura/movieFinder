//
//  MovieDetailsServiceProtocol.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

protocol MovieDetailsServiceProtocol {
    func fetchMovieDetails(movieId: Int, language: String) async throws -> Movie
}
