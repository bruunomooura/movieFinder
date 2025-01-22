//
//  DevelopmentServiceFactory.swift.swift
//  MovieFinder
//
//  Created by Bruno Moura on 20/01/25.
//

final class DevelopmentServiceFactory: ServiceFactoryProtocol {
    func makeMovieDetailsService() -> any MovieDetailsServiceProtocol {
        return MockMovieDetailsService()
    }
    
    func makeGenreService() -> any GenreServiceProtocol {
        return MockGenreService()
    }
    
    func makeSimilarMoviesService() -> any SimilarMoviesServiceProtocol {
        return MockSimilarMoviesService()
    }
}
