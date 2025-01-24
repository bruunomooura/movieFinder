//
//  MovieHeaderTableViewCell.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

import UIKit

protocol MovieHeaderTableViewCellDelegate: AnyObject {
    func didSelectedLikeButton(_ sender: UIButton)
}

class MovieHeaderTableViewCell: UITableViewCell {
    
    private weak var delegate: MovieHeaderTableViewCellDelegate?
    
    static let identifier: String = String(describing: MovieHeaderTableViewCell.self)
    private let likeCount: StatsView = StatsView()
    private let popularityCount: StatsView = StatsView()
    private var likedMovie: Bool = .init()
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
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
        configurationButton.contentInsets = .init(top: 15, leading: 15, bottom: 15, trailing: 15)
        configurationButton.baseBackgroundColor = .clear
        
        button.configuration = configurationButton
        button.addTarget(self, action: #selector(tappedLikeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 25
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
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
    // MARK: Delegate
    /// Sets the delegate for the MovieHeaderTableViewCell.
    ///
    /// - Parameter delegate: The delegate object conforming to the `MovieHeaderTableViewCellDelegate` protocol.
    public func delegate(delegate: MovieHeaderTableViewCellDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: Configure Cell
    /// Configures the cell with the provided movie data.
    ///
    /// - Parameter movie: An instance of `Movie` containing the data to populate the cell.
    public func configureCell(movie: Movie) {
        movieTitleLabel.text = movie.title
        movieTitleLabel.accessibilityHint = movie.title
        setupStatsViews(likesValue: movie.voteCount.formatAsAbbreviated(),
                        popularityValue: Int(movie.popularity).formatAsAbbreviated())
        updateLikeButtonImage()
    }
    
    // MARK: Private Methods
    @objc
    private func tappedLikeButton(_ sender: UIButton) {
        likeButton.transform = CGAffineTransform.identity
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            likedMovie.toggle()
            self.delegate?.didSelectedLikeButton(sender)
            
            updateLikeButtonImage()
            likeButton.animateImageBounce()
        }
    }
    
    private func setupStatsViews(likesValue: String, popularityValue: String) {
        let heartIcon = UIImage(systemName: SystemImage.heartFill.rawValue)
        likeCount.setupComponent(icon: heartIcon, title: String(format: "movieDetails.likeCount".localized, likesValue))
        
        let starIcon = UIImage(systemName: SystemImage.starFill.rawValue)
        popularityCount.setupComponent(icon: starIcon, title: String(format: "movieDetails.popularity".localized, popularityValue))
    }
    
    private func updateLikeButtonImage() {
        let iconImage = UIImage(systemName: likedMovie == true
                                ? SystemImage.heartFill.rawValue
                                : SystemImage.heart.rawValue)?
            .withTintColor(.buttonBackground, renderingMode: .alwaysOriginal)
        likeButton.setImage(iconImage, for: .normal)
    }
}

// MARK: - ViewCode Protocol Conformance
extension MovieHeaderTableViewCell: ViewCode {
    
    // MARK: Adding Subviews
    func addSubviews() {
        addSubview(movieTitleLabel)
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(likeCount)
        horizontalStackView.addArrangedSubview(popularityCount)
        contentView.addSubview(likeButton)
    }
    
    // MARK: Setting Up Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            likeButton.topAnchor.constraint(equalTo: movieTitleLabel.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            likeButton.leadingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor, constant: 20),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            
            horizontalStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 15),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: Styling the Cell
    func setupStyle() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
    }
}
