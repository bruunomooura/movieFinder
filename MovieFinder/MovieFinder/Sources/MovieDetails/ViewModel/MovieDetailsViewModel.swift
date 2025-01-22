//
//  MovieDetailsViewModel.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation
import UIKit

protocol MovieDetailsViewModelDelegate: AnyObject {
    //    func updateData(content: [Movie])
    func errorLoadingData(message: String)
    func loadDataCompleted(genresDictionary: [Int: String], movieDetails: Movie?, similarMovies: [Movie])
}

final class MovieDetailsViewModel {
    private let genreServiceProtocol: GenreServiceProtocol
    private let movieDetailsServiceProtocol: MovieDetailsServiceProtocol
    private let similarMoviesServiceProtocol: SimilarMoviesServiceProtocol
    private weak var delegate: MovieDetailsViewModelDelegate?
    
    private var genresDictionary: [Int: String] = [:]
    
    private var movieDetails: Movie?
    //    private var movieImage: UIImage?
    private var similarMoviesList: [Movie] = []
    private var isLoading: Bool = .init()
    private var movieId: Int = 68721
    private var language: String = "pt-BR"
    private var currentPage: Int = 1
    
    
    //    public var noResults: Bool {
    //        if moviesList.isEmpty {
    //            return true
    //        } else {
    //            return false
    //        }
    //    }
    
    init(genreServiceProtocol: GenreServiceProtocol = AppConfig.serviceFactory.makeGenreService(),
         movieDetailsServiceProtocol: MovieDetailsServiceProtocol = AppConfig.serviceFactory.makeMovieDetailsService(),
         similarMoviesServiceProtocol: SimilarMoviesServiceProtocol = AppConfig.serviceFactory.makeSimilarMoviesService()) {
        self.genreServiceProtocol = genreServiceProtocol
        self.movieDetailsServiceProtocol = movieDetailsServiceProtocol
        self.similarMoviesServiceProtocol = similarMoviesServiceProtocol
    }
}

// MARK: - Functions
extension MovieDetailsViewModel {
    public func delegate(delegate: MovieDetailsViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func loadData() async {
        isLoading = true
        do {
            async let genres = genreServiceProtocol.fetchGenres(
                language: language)
            async let movieDetails = movieDetailsServiceProtocol.fetchMovieDetails(
                movieId: movieId,
                language: language)
            async let similarMovies = similarMoviesServiceProtocol.fetchRelatedMovies(
                movieId: movieId,
                language: language)
            
            let genresResult = try await genres
            let movieDetailsResult = try await movieDetails
            let similarMoviesResult = try await similarMovies
            
            configGenresDictionary(with: genresResult.genres)
            
            self.movieDetails = movieDetailsResult
            self.similarMoviesList = similarMoviesResult.results
            
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.delegate?.loadDataCompleted(
                    genresDictionary: self.genresDictionary,
                    movieDetails: self.movieDetails,
                    similarMovies: self.similarMoviesList)
            }
        } catch {
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.delegate?.errorLoadingData(message: error.localizedDescription)
            }
        }
    }
    
    private func configGenresDictionary(with genres: [Genre]) {
        genresDictionary = Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })
    }
}
