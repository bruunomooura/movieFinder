//
//  MovieDetailsViewModelDelegateSpy.swift
//  MovieFinder
//
//  Created by Bruno Moura on 14/09/25.
//

import XCTest
@testable import MovieFinder

class MovieDetailsViewModelDelegateSpy: MovieDetailsViewModelDelegate {
    private(set) var loadMovieDetailsSuccessCallCount = 0
    private(set) var receivedMovieDetails: Movie?
    
    private(set) var loadGenresAndSimilarMoviesSuccessCallCount = 0
    private(set) var receivedGenresDictionary: [Int : String]?
    private(set) var receivedSimilarMovies: [Movie]?
    private(set) var receivedIndexPath: [IndexPath]?
    
    private(set) var errorLoadingDataCallCount = 0
    private(set) var receivedErrorMessage: String?
    
    private(set) var showNoSimilarMoviesFoundCallCount = 0
    
    func errorLoadingData(message: String) {
        errorLoadingDataCallCount += 1
        receivedErrorMessage = message
    }
    
    func loadMovieDetailsSuccess(movieDetails: Movie?) {
        loadMovieDetailsSuccessCallCount += 1
        receivedMovieDetails = movieDetails
    }
    
    func loadGenresAndSimilarMoviesSuccess(genresDictionary: [Int : String], similarMovies: [Movie], _ indexPath: [IndexPath]) {
        loadGenresAndSimilarMoviesSuccessCallCount += 1
        receivedGenresDictionary = genresDictionary
        receivedSimilarMovies = similarMovies
        receivedIndexPath = indexPath
    }
    
    func showNoSimilarMoviesFound() {
        showNoSimilarMoviesFoundCallCount += 1
    }
}
