//
//  MoviesDetailsTableViewDataSource.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

final class MoviesDetailsTableViewDataSource: NSObject, UITableViewDataSource {
    
//    weak var delegateMoviePoster: MoviePosterTableViewCellDelegate?
    weak var delegateMovieHeader: MovieHeaderTableViewCellDelegate?
    private var genresDictionary: [Int: String] = [:]
    private var movieDetails: Movie?
    private var similarMovies: [Movie] = []
//    var didScrollNearEnd: (() -> Void)?
    
    func setupInitialData(movieDetails: Movie?) {
        self.movieDetails = movieDetails
    }
    
    func setupSecondaryData(genresDictionary: [Int: String],
                            similarMovies: [Movie]) {
        self.genresDictionary = genresDictionary
        self.similarMovies = similarMovies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarMovies.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviePosterTableViewCell.identifier, for: indexPath) as? MoviePosterTableViewCell else { return UITableViewCell() }
            
            // Configure a célula da capa usando o objeto `movie` correspondente
            guard let movieDetails = movieDetails else { return UITableViewCell()}
//            cell.delegate(delegate: delegateMoviePoster)
            cell.configureCell(movie: movieDetails)
            cell.animateMoviePosterImageView()
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieHeaderTableViewCell.identifier, for: indexPath) as? MovieHeaderTableViewCell else { return UITableViewCell() }
            
            // Configure a célula do cabeçalho usando o mesmo objeto `movie`
            guard let movieDetails = movieDetails else { return UITableViewCell()}
            cell.delegate(delegate: delegateMovieHeader)
            cell.configureCell(movie: movieDetails)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.identifier, for: indexPath) as? SimilarMovieTableViewCell else { return UITableViewCell() }
            
            // Calcula o índice correto para a lista de filmes similares
            let similarIndex = indexPath.row - 2
            let similarMovie = similarMovies[similarIndex]
            
            // Configure a célula com o filme similar
            cell.configureCell(movie: similarMovie, genres: genresDictionary)
            return cell
        }
    }
}

extension MoviesDetailsTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 440
        case 1:
            return 80
        default:
            return 130
        }
    }
}
