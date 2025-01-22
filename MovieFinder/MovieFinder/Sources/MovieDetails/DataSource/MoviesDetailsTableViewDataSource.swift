//
//  MoviesDetailsTableViewDataSource.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

final class MoviesDetailsTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var genresDictionary: [Int: String] = [:]
    private var movieDetails: Movie?
    private var similarMovies: [Movie] = []
//    var didScrollNearEnd: (() -> Void)?
    
    func reloadTableView(genresDictionary: [Int: String],
                         movieDetails: Movie?,
                         similarMovies: [Movie]) {
        self.genresDictionary = genresDictionary
        self.movieDetails = movieDetails
        self.similarMovies = similarMovies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + similarMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviePosterTableViewCell.identifier, for: indexPath) as? MoviePosterTableViewCell else { return UITableViewCell() }
            
            // Configure a célula da capa usando o objeto `movie` correspondente
            guard let movieDetails = movieDetails else { return UITableViewCell()}
            cell.configureCell(movie: movieDetails)
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieHeaderTableViewCell.identifier, for: indexPath) as? MovieHeaderTableViewCell else { return UITableViewCell() }
            
            // Configure a célula do cabeçalho usando o mesmo objeto `movie`
            guard let movieDetails = movieDetails else { return UITableViewCell()}
            cell.configureCell(movie: movieDetails)
            
            return cell
        } else {
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
        if indexPath.row == 0 {
            return 250
        } else if indexPath.row == 1 {
            return 150
        } else {
            return 130
        }
    }
}
