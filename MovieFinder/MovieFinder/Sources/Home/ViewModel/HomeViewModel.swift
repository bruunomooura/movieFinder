//
//  HomeViewModel.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func setupTitles()
}

final class HomeViewModel {
    let welcomeLabelText = "home.description".localized
    let welcomeButtonTitle = "home.button.title".localized
    
    private weak var delegate: HomeViewModelDelegate?
}

extension HomeViewModel {
    public func delegate(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func setupTitles() {
        delegate?.setupTitles()
    }
}
