//
//  infoMovieView.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

public class infoMovieView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .clear
        return imageView
    }()
       
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(icon: UIImage, title: String) {
        super.init(frame: .zero)
        setupComponent(icon: icon, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent(icon: UIImage, title: String) {
        iconImageView.image = icon
        infoLabel.text = title
        setup()
        
//        iconImageView.tintColor = UIColor.white
        
        
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.textColor = UIColor.white
        
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
       
    }
    
//    func configure(withImage image: UIImage?, value: String) {
//        iconImageView.image = image
//        infoLabel.text = value
//    }
}

extension infoMovieView: ViewCode {
    func addSubviews() {
        self.addSubview(iconImageView)
        self.addSubview(infoLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            infoLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            infoLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
    }
    
    func setupStyle() {
        iconImageView.tintColor = UIColor.white
        infoLabel.tintColor = UIColor.white
    }
}
