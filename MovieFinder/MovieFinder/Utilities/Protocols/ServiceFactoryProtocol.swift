//
//  ServiceFactoryProtocol.swift
//  MovieFinder
//
//  Created by Bruno Moura on 20/01/25.
//

protocol ServiceFactoryProtocol {
    func makeMovieDetailsService() -> MovieDetailsServiceProtocol
    func makeGenreService() -> GenreServiceProtocol
    func makeSimilarMoviesService() -> SimilarMoviesServiceProtocol
}
