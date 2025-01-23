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
    
    private var likedMovie: Bool = .init()
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .top
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .clear
        label.isAccessibilityElement = true
        label.accessibilityLabel = "movieDetails.movieTitle.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configurationButton = UIButton.Configuration.filled()
        configurationButton.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        //        configurationButton.imagePadding = 8
        //        configurationButton.imagePlacement = .all
        //        configurationButton.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        configurationButton.baseBackgroundColor = .clear
        
        button.configuration = configurationButton
        button.addTarget(self, action: #selector(tappedLikeButton), for: .touchDown)
        return button
    }()
    
    @objc
    private func tappedLikeButton(_ sender: UIButton) {
        print("Like button tocado")
        sender.animateImageBounce()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            likedMovie.toggle()
            self.delegate?.didSelectedLikeButton(sender)
            
            setLikeButtonImage()
        }
    }
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = false
        //        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0,
        //                                                                     leading: 10,
        //                                                                     bottom: 0,
        //                                                                     trailing: 10)
        //        stackView.backgroundColor = .purple
                stackView.alignment = .leading
        //        stackView.distribution = .fill
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
    public func delegate(delegate: MovieHeaderTableViewCellDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: Configure Cell
    /**
     Configures the cell with flight information.
     
     - Parameter movie: The Movie object containing the movie data to populate the cell.
     */
    public func configureCell(movie: Movie) {
        movieTitleLabel.text = movie.title
        setupInfoMovieViews(likesValue: movie.voteCount.formatAsAbbreviated(),
                            popularityValue: Int(movie.popularity).formatAsAbbreviated())
        setLikeButtonImage()
    }
    
    private func setupInfoMovieViews(likesValue: String, popularityValue: String) {
        guard let iconOne = UIImage(systemName: SystemImage.heartFill.rawValue) else { return }
        let likeCount: infoMovieView = infoMovieView(icon: iconOne, title: "\(likesValue) Curtidas")
        
        guard let iconTwo = UIImage(systemName: SystemImage.heartFill.rawValue) else { return }
        let popularityCount: infoMovieView = infoMovieView(icon: iconTwo, title: "\(popularityValue) Visualizações")
        
        horizontalStackView.addArrangedSubview(likeCount)
        horizontalStackView.addArrangedSubview(popularityCount)
    }
    
    private func setLikeButtonImage() {
        let iconImage = UIImage(systemName: likedMovie == true
                                ? SystemImage.heartFill.rawValue
                                : SystemImage.heart.rawValue)?
            .withTintColor(.buttonBackground, renderingMode: .alwaysOriginal)
        likeButton.setImage(iconImage, for: .normal)
    }
    
}

extension MovieHeaderTableViewCell: ViewCode {
    func addSubviews() {
        addSubview(movieTitleLabel)
        addSubview(horizontalStackView)
        
        contentView.addSubview(likeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieTitleLabel.widthAnchor.constraint(equalToConstant: 300),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            likeButton.topAnchor.constraint(equalTo: movieTitleLabel.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            likeButton.widthAnchor.constraint(equalToConstant: 25),
            likeButton.heightAnchor.constraint(equalToConstant: 25),
            
            horizontalStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .clear
    }
}

