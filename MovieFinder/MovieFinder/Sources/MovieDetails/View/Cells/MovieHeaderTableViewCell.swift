//
//  MovieHeaderTableViewCell.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

class MovieHeaderTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: MovieHeaderTableViewCell.self)
    
    private var likedMovie: Bool = .init()
    private let likeCount: ImageLabelView = ImageLabelView()
    private let popularityCount: ImageLabelView = ImageLabelView()
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.isAccessibilityElement = true
        label.accessibilityLabel = "movieDetails.movieTitle.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configurationButton = UIButton.Configuration.filled()
        configurationButton.imagePadding = 8
        configurationButton.imagePlacement = .all
        configurationButton.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        configurationButton.baseBackgroundColor = .clear
        
        button.configuration = configurationButton
        button.addTarget(self, action: #selector(tappedLikeButton), for: .touchDown)
        return button
    }()
    
    @objc
    private func tappedLikeButton(_ sender: UIButton) {
        sender.animateTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            likedMovie.toggle()
            
            let iconImage = UIImage(systemName: likedMovie == true
                                    ? SystemImage.heartFill.rawValue
                                    : SystemImage.heart.rawValue)?
                .withTintColor(.buttonBackground, renderingMode: .alwaysOriginal)
            likeButton.setImage(iconImage, for: .normal)
        }
    }
    
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
extension MovieHeaderTableViewCell {
    // MARK: Configure Cell
    /**
     Configures the cell with flight information.
     
     - Parameter movie: The Movie object containing the movie data to populate the cell.
     */
    public func configureCell(movie: Movie) {
        movieTitleLabel.text = movie.title
        configureCustomViews(likesValue: Int(movie.voteCount).formatAsAbbreviated(),
                             popularityValue: Int(movie.popularity).formatAsAbbreviated())
    }
    
    public func configureCustomViews(likesValue: String, popularityValue: String) {
        likeCount.configure(withImage:UIImage(systemName: SystemImage.heartFill.rawValue), value: likesValue)
        popularityCount.configure(withImage: UIImage(systemName: SystemImage.heart.rawValue), value: popularityValue)
    }
    
}

extension MovieHeaderTableViewCell: ViewCode {
    func addSubviews() {
        addSubview(movieTitleLabel)
        addSubview(likeButton)
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(likeCount)
        horizontalStackView.addArrangedSubview(popularityCount)
        
    }
    
    func setupConstraints() {
        likeCount.translatesAutoresizingMaskIntoConstraints = false
        popularityCount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            movieTitleLabel.widthAnchor.constraint(equalToConstant: 300),
            
            likeButton.topAnchor.constraint(equalTo: movieTitleLabel.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            horizontalStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            likeCount.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            likeCount.centerYAnchor.constraint(equalTo: horizontalStackView.centerYAnchor),
            popularityCount.leadingAnchor.constraint(equalTo: likeCount.trailingAnchor, constant: 10),
            popularityCount.centerYAnchor.constraint(equalTo: horizontalStackView.centerYAnchor),
        ])
    }
    
    func setupStyle() {
        backgroundColor = .clear
    }
}

