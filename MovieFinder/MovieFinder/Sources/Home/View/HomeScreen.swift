//
//  HomeScreen.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

protocol HomeScreenDelegate: AnyObject {
    func didTapWelcomeButton()
}

class HomeScreen: UIView {
    
    private weak var delegate: HomeScreenDelegate?
    
    public func delegate(delegate: HomeScreenDelegate?) {
        self.delegate = delegate
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.logoMovieFinder
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.isAccessibilityElement = true
        imageView.accessibilityTraits = .none
        imageView.accessibilityLabel = "home.appName".localized

        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.isAccessibilityElement = true
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var welcomeButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.background, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.isAccessibilityElement = true
        button.backgroundColor = .buttonBackground
        button.accessibilityTraits = .button
        button.addTarget(self, action: #selector(tappedWelcomeButton), for: .touchDown)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 60
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

// MARK: - Functions
extension HomeScreen {
    
    /// Sets up the titles for the welcome label and welcome button.
    ///
    /// - Parameters:
    ///   - welcomeLabelText: The text to be displayed on the welcome label.
    ///   - welcomeButtonTitle: The title to be displayed on the welcome button.
    public func setupTitles(_ welcomeLabelText: String, _ welcomeButtonTitle: String) {
        logoImageView.accessibilityIdentifier = "logoImageView"
        
        welcomeLabel.text = welcomeLabelText
        welcomeLabel.accessibilityLabel = welcomeLabelText
        welcomeLabel.accessibilityIdentifier = "welcomeLabel"
        
        welcomeButton.setTitle(welcomeButtonTitle, for: .normal)
        welcomeButton.accessibilityLabel = welcomeButtonTitle
        welcomeButton.accessibilityIdentifier = "welcomeButton"
    }
    
    /// Handles the tap event for the welcome button.
    ///
    /// This method triggers an animation for the button and notifies the delegate
    /// after a short delay, indicating that the welcome button has been tapped.
    ///
    /// - Parameter sender: The UIButton that was tapped.
    @objc
    private func tappedWelcomeButton(_ sender: UIButton) {
        sender.animateTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapWelcomeButton()
        }
    }
}

extension HomeScreen: ViewCode {
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(welcomeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            logoImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40),
            logoImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40),
            
            welcomeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            welcomeLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            welcomeButton.heightAnchor.constraint(equalToConstant: 60),
            welcomeButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 60),
            welcomeButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -60),
        ])
    }
    
    func setupStyle() {
        backgroundColor = UIColor.background
    }
}
