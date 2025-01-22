//
//  MoviePosterTableViewCell.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

final class MoviePosterTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: MoviePosterTableViewCell.self)
    
    private lazy var movieImageView: UIImageView = {
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
    // MARK: Configure Cell
    /**
     Configures the cell with flight information.
     
     - Parameter movie: The Movie object containing the movie data to populate the cell.
     */
    public func configureCell(movie: Movie) {
        movieImageView.loadImageFromURL(movie.imageURL)
    }
}

extension MoviePosterTableViewCell: ViewCode {
    func addSubviews() {
        addSubview(movieImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    func setupStyle() {
        backgroundColor = .clear
    }
}
