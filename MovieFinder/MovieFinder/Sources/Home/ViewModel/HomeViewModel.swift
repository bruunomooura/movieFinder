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

// MARK: - Functions
extension HomeViewModel {
    /// Sets the delegate for the HomeViewModel.
    ///
    /// - Parameter delegate: An optional object conforming to the `HomeViewModelDelegate` protocol.
    public func delegate(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
    }
    
    /// Informs the delegate to set up titles.
    ///
    /// This method calls the `setupTitles` method on the delegate, allowing the delegate
    /// to configure the titles in the UI.
    public func setupTitles() {
        delegate?.setupTitles()
    }
}
