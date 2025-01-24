//
//  GenreServiceProtocol.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

protocol GenreServiceProtocol {
    func fetchGenres(language: String) async throws -> GenreResponse
}
