//
//  StatsView.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

public class StatsView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
       
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupComponent(icon: UIImage?, title: String) {
        iconImageView.image = icon
        infoLabel.text = title
        setup()
        
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.textColor = UIColor.white
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension StatsView: ViewCode {
    func addSubviews() {
        self.addSubview(iconImageView)
        self.addSubview(infoLabel)
    }
    
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
    
    func setupStyle() {
        iconImageView.tintColor = UIColor.white
        infoLabel.tintColor = UIColor.white
    }
}
