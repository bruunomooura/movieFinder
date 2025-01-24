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
    func loadMovieDetailsSuccess(movieDetails: Movie?)
    func loadGenresAndSimilarMoviesSuccess(genresDictionary: [Int: String], similarMovies: [Movie], _ indexPath: [IndexPath])
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
    
    public func loadMovieDetails() async {
        isLoading = true
        do {
            async let movieDetails = movieDetailsServiceProtocol.fetchMovieDetails(
                movieId: movieId,
                language: language)
            
            let movieDetailsResult = try await movieDetails
            
            self.movieDetails = movieDetailsResult
            
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.delegate?.loadMovieDetailsSuccess(movieDetails: self.movieDetails)
            }
        } catch {
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.delegate?.errorLoadingData(message: error.localizedDescription)
            }
        }
    }
    
    public func loadGenresAndSimilarMovies() async {
        isLoading = true
        do {
            async let genres = genreServiceProtocol.fetchGenres(
                language: language)
            async let similarMovies = similarMoviesServiceProtocol.fetchRelatedMovies(
                movieId: movieId,
                language: language)
            
            let genresResult = try await genres
            let similarMoviesResult = try await similarMovies
            
            configGenresDictionary(with: genresResult.genres)
            self.similarMoviesList = similarMoviesResult.results
            let indexPath = defineIndexPath(similarMovies: similarMoviesResult.results)
            
            
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.delegate?.loadGenresAndSimilarMoviesSuccess(
                    genresDictionary: self.genresDictionary,
                    similarMovies: self.similarMoviesList, indexPath)
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
    
    private func defineIndexPath(similarMovies: [Movie]) -> [IndexPath] {
        let newIndexPath = (0..<similarMovies.count).map { IndexPath(row: $0, section: 0) }
        return newIndexPath
    }
}
