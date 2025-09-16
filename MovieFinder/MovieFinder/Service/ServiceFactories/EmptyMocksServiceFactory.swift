//
//  EmptyMocksServiceFactory.swift
//  MovieFinder
//
//  Created by Bruno Moura on 16/09/25.
//


final class EmptyMocksServiceFactory: ServiceFactoryProtocol {
    func makeMovieDetailsService() -> any MovieDetailsServiceProtocol {
        return MockMovieDetailsService()
    }
    func makeGenreService() -> any GenreServiceProtocol {
        return MockGenreService()
    }
    func makeSimilarMoviesService() -> any SimilarMoviesServiceProtocol {
        let mock = MockSimilarMoviesService()
        mock.result = .success(MovieResponse(results: []))
        return mock
    }
}
