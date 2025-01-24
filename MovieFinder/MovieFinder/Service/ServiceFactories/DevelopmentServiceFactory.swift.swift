//
//  DevelopmentServiceFactory.swift.swift
//  MovieFinder
//
//  Created by Bruno Moura on 20/01/25.
//

/// A factory for creating mock services used in development and testing.
///
/// This class conforms to the `ServiceFactoryProtocol` and provides implementations
/// for creating instances of various service protocols for movie details, genres,
/// and similar movies.
final class DevelopmentServiceFactory: ServiceFactoryProtocol {
    
    /// Creates and returns a mock service for fetching movie details.
    ///
    /// - Returns: An instance of a type conforming to `MovieDetailsServiceProtocol`.
    func makeMovieDetailsService() -> any MovieDetailsServiceProtocol {
        return MockMovieDetailsService()
    }
    
    /// Creates and returns a mock service for fetching genres.
    ///
    /// - Returns: An instance of a type conforming to `GenreServiceProtocol`.
    func makeGenreService() -> any GenreServiceProtocol {
        return MockGenreService()
    }
    
    /// Creates and returns a mock service for fetching similar movies.
    ///
    /// - Returns: An instance of a type conforming to `SimilarMoviesServiceProtocol`.
    func makeSimilarMoviesService() -> any SimilarMoviesServiceProtocol {
        return MockSimilarMoviesService()
    }
}
