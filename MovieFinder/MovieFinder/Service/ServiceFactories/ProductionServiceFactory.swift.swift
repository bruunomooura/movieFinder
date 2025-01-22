//
//  ProductionServiceFactory.swift.swift
//  MovieFinder
//
//  Created by Bruno Moura on 20/01/25.
//

final class ProductionServiceFactory: ServiceFactoryProtocol {
    func makeMovieDetailsService() -> any MovieDetailsServiceProtocol {
        return MovieDetailsServiceManager()
    }
    
    func makeGenreService() -> any GenreServiceProtocol {
        return GenreServiceManager()
    }
    
    func makeSimilarMoviesService() -> any SimilarMoviesServiceProtocol {
        return SimilarMoviesServiceManager()
    }
}
