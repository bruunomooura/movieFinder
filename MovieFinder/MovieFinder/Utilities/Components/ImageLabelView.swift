//
//  ImageLabelView.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

class ImageLabelView: UIView {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imageView.tintColor = UIColor.white
        addSubview(imageView)
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
//            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(withImage image: UIImage?, value: String) {
        imageView.image = image
        label.text = value
    }
}
