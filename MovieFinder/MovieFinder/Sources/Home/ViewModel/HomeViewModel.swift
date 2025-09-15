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

protocol HomeViewModelProtocol: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    func setupTitles()
}

final class HomeViewModel: HomeViewModelProtocol {
    let welcomeLabelText = "home.description".localized
    let welcomeButtonTitle = "home.button.title".localized
    
    weak var delegate: HomeViewModelDelegate?
}

// MARK: - Functions
extension HomeViewModel {
    public func setupTitles() {
        delegate?.setupTitles()
    }
}
