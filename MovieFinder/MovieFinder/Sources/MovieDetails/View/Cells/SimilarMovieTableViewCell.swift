//
//  SimilarMovieTableViewCell.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

class SimilarMovieTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: SimilarMovieTableViewCell.self)
  
    private lazy var moviePosterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var movieTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.accessibilityLabel = "movieDetails.movieTitle.accessibilityLabel".localized
        return label
    }()
    
    private lazy var movieReleaseLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.accessibilityLabel = "movieDetails.movieReleaseLabel.accessibilityLabel".localized
        return label
    }()
    
    private lazy var movieGenresLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.accessibilityLabel = "movieDetails.movieGenresLabel.accessibilityLabel".localized
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0,
                                                                     leading: 10,
                                                                     bottom: 0,
                                                                     trailing: 10)
        stackView.backgroundColor = .clear
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10,
                                                                     leading: 10,
                                                                     bottom: 10,
                                                                     trailing: 10)
        stackView.backgroundColor = .clear
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - Functions
extension SimilarMovieTableViewCell {
    // MARK: Configure Cell
    /// Configures the cell with flight information.
    ///
    /// This function populates the cell with movie-related data, including the movie's poster, title,
    /// release date, and genres. It uses the provided genres dictionary to translate genre IDs into genre names.
    ///
    /// - Parameter movie: The `Movie` object containing the movie data to populate the cell.
    /// - Parameter genres: A dictionary mapping genre IDs to genre names used to display the movie's genres.
    ///
    public func configureCell(movie: Movie, genres: [Int: String]) {
        moviePosterImageView.loadImageFromURL(movie.imageURL)
        movieTitleLabel.text = movie.title.formatWithLineBreaks(every: 4)
        movieReleaseLabel.text = movie.releaseYear
        movieGenresLabel.text = movie.genreNames(using: genres)
    }
}

extension SimilarMovieTableViewCell: ViewCode {
    func addSubviews() {
        addSubview(moviePosterImageView)
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(movieTitleLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(movieReleaseLabel)
        horizontalStackView.addArrangedSubview(movieGenresLabel)
//        addSubview(movieTitleLabel)
//        addSubview(movieReleaseLabel)
//        addSubview(movieGenresLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            moviePosterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            moviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: 65),
            
            verticalStackView.centerYAnchor.constraint(equalTo: moviePosterImageView.centerYAnchor),
//            verticalStackView.topAnchor.constraint(equalTo: moviePosterImageView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 20),
//            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            verticalStackView.bottomAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor),
//            movieTitleLabel.bottomAnchor.constraint(equalTo: moviePosterImageView.centerYAnchor, constant: -20),
//            movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 16),
//            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            
//            movieReleaseLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
//            movieReleaseLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
//            
//            movieGenresLabel.topAnchor.constraint(equalTo: movieReleaseLabel.topAnchor),
//            movieGenresLabel.leadingAnchor.constraint(equalTo: movieReleaseLabel.trailingAnchor, constant: 8)
        ])
    }
    
    func setupStyle() {
        backgroundColor = .black
    }
}
