//
//  MoviePosterTableViewCell.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

//protocol MoviePosterTableViewCellDelegate: AnyObject {
//    func didDisplayMoviePoster(cell: MoviePosterTableViewCell)
//}

final class MoviePosterTableViewCell: UITableViewCell {

//    private weak var delegate: MoviePosterTableViewCellDelegate?
    static let identifier: String = String(describing: MoviePosterTableViewCell.self)
    
    private lazy var moviePosterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
//        imageView.layer.cornerRadius = 0
//        imageView.frame = CGRect(x: 0, y: 0, width: <#0#>, height: 300)
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
//        backgroundColor = .yellow
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
//    public func delegate(delegate: MoviePosterTableViewCellDelegate?) {
//        self.delegate = delegate
//    }
    
    // MARK: Configure Cell
    /**
     Configures the cell with flight information.
     
     - Parameter movie: The Movie object containing the movie data to populate the cell.
     */
    public func configureCell(movie: Movie) {
        moviePosterImageView.loadImageFromURL(movie.imageURL(size: .w780, pathImage: .backdropPath))
    }
    
    func animateMoviePosterImageView() {
          UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
              self.moviePosterImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
              self.moviePosterImageView.transform = .identity
          }, completion: nil)
      }
}

extension MoviePosterTableViewCell: ViewCode {
    func addSubviews() {
        addSubview(moviePosterImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            moviePosterImageView.topAnchor.constraint(equalTo: topAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviePosterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    func setupStyle() {
        backgroundColor = .clear
    }
}
