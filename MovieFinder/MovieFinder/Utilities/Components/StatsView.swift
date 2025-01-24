//
//  StatsView.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

/// A reusable UIView component that displays an icon alongside a descriptive label.
///
/// `StatsView` is a custom view designed to present an icon and a title side-by-side.
/// It is built using programmatic layout (ViewCode) and is accessible by default.
///
public class StatsView: UIView {
    
    /// The `UIImageView` used to display the icon.
    private let iconImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// The `UILabel` used to display the title text.
    /// Accessibility is enabled for this label by default.
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        return label
    }()
    
    // MARK: - Initializers
    
    /// Initializes a new `StatsView` instance.
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    /// Configures the view with an icon and a title.
    ///
    /// This method assigns an image to the `iconImageView` and text to the `infoLabel`.
    /// It also updates the accessibility label to match the provided title.
    ///
    /// - Parameters:
    ///   - icon: The `UIImage` to display as the icon. Pass `nil` if no icon is needed.
    ///   - title: A `String` representing the title to display next to the icon.
    public func setupComponent(icon: UIImage?, title: String) {
        iconImageView.image = icon
        infoLabel.text = title
        
        configureAccessibility(with: title)
        
        setup()
        
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.textColor = UIColor.white
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Configures accessibility for the view.
    ///
    /// This method sets the `accessibilityLabel` and `accessibilityTraits` for the `infoLabel`
    /// to ensure the component is accessible and descriptive.
    ///
    /// - Parameter title: The `String` to use as the accessibility label.
    private func configureAccessibility(with title: String) {
        infoLabel.accessibilityLabel = title
        infoLabel.accessibilityTraits = .none
    }
}
// MARK: - ViewCode Protocol Conformance

extension StatsView: ViewCode {
    /// Adds the subviews (`iconImageView` and `infoLabel`) to the view hierarchy.
    func addSubviews() {
        self.addSubview(iconImageView)
        self.addSubview(infoLabel)
    }
    
    /// Sets up the constraints for the subviews.
    ///
    /// - `iconImageView` is positioned at the leading edge of the view.
    /// - `infoLabel` is aligned horizontally with `iconImageView` and positioned to its right.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            infoLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            infoLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    /// Configures the style of the subviews.
    ///
    /// Sets the tint color of both `iconImageView` and `infoLabel` to white.
    func setupStyle() {
        iconImageView.tintColor = .white
        infoLabel.tintColor = .white
    }
}
