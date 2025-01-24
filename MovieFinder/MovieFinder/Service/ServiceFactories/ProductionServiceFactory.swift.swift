//
//  ProductionServiceFactory.swift.swift
//  MovieFinder
//
//  Created by Bruno Moura on 20/01/25.
//

/// A factory for creating production services used in the application.
///
/// This class conforms to the `ServiceFactoryProtocol` and provides implementations
/// for creating instances of various service protocols for movie details, genres,
/// and similar movies in a production environment.
final class ProductionServiceFactory: ServiceFactoryProtocol {
    
    /// Creates and returns a service for fetching movie details.
    ///
    /// - Returns: An instance of a type conforming to `MovieDetailsServiceProtocol`.
    func makeMovieDetailsService() -> any MovieDetailsServiceProtocol {
        return MovieDetailsServiceManager()
    }
    
    /// Creates and returns a service for fetching genres.
    ///
    /// - Returns: An instance of a type conforming to `GenreServiceProtocol`.
    func makeGenreService() -> any GenreServiceProtocol {
        return GenreServiceManager()
    }
    
    /// Creates and returns a service for fetching similar movies.
    ///
    /// - Returns: An instance of a type conforming to `SimilarMoviesServiceProtocol`.
    func makeSimilarMoviesService() -> any SimilarMoviesServiceProtocol {
        return SimilarMoviesServiceManager()
    }
}
