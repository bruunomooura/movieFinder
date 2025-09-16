//
//  MoviePosterTableViewCell.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

final class MoviePosterTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: MoviePosterTableViewCell.self)
    
    private lazy var moviePosterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.isAccessibilityElement = false
        imageView.accessibilityIdentifier = "moviePosterImageView"
        return imageView
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
extension MoviePosterTableViewCell {
    // MARK: Configure Cell
    /// Configures the cell with movie information.
    ///
    /// This method takes a `Movie` object and loads the movie poster image from the URL specified in the movie data.
    ///
    /// - Parameter movie: The `Movie` object containing the movie data to populate the cell.
    ///   The movie's image URL is used to load the image for the poster.
    ///
    
    public func configureCell(movie: Movie) {
        moviePosterImageView.loadImageFromURL(movie.imageURL(size: .w780, pathImage: .backdropPath))
    }
    
    /// Animates the movie poster image view.
    ///
    /// This method applies a scaling animation to the `moviePosterImageView`, enlarging and then restoring its size.
    /// The animation runs with a duration of 1 second and an ease-out curve.
    ///
    /// - Note: This animation is typically used to create a visual effect when displaying the movie poster.
    ///
    func animateMoviePosterImageView() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.moviePosterImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.moviePosterImageView.transform = .identity
        }, completion: nil)
    }
}

extension MoviePosterTableViewCell: ViewCode {
    
    /// Adds the subviews to the cell's content view.
    ///
    /// This method adds the `moviePosterImageView` to the view hierarchy. It is called when the cell is being set up.
    ///
    func addSubviews() {
        addSubview(moviePosterImageView)
    }
    
    /// Sets up the constraints for the subviews.
    ///
    /// This method defines the layout constraints for the `moviePosterImageView` to make it fill the entire
    /// bounds of the cell.
    ///
    func setupConstraints() {
        NSLayoutConstraint.activate([
            moviePosterImageView.topAnchor.constraint(equalTo: topAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviePosterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    /// Sets up the style for the cell.
    ///
    /// This method customizes the appearance of the cell, including setting the background color to clear.
    ///
    func setupStyle() {
        backgroundColor = .clear
    }
}
