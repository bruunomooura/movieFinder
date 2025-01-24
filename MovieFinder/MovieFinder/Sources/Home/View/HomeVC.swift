//
//  HomeVC.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

class HomeVC: UIViewController {
    
    var viewModel: HomeViewModel = HomeViewModel()
    var screen: HomeScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(delegate: self)
        viewModel.delegate(delegate: self)
        viewModel.setupTitles()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.screen =  HomeScreen()
        view = screen
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

// MARK: - HomeScreenDelegate
extension HomeVC: HomeScreenDelegate {
    
    /// Configures the navigation bar appearance and title.
    private func setupNavigationBar() {
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    /// Handles the event when the welcome button is tapped.
    ///
    /// This method instantiates the `MovieDetailsVC` and pushes it onto the navigation stack,
    /// allowing the user to view details about a selected movie.
    func didTapWelcomeButton() {
        let movieDetailsVC = MovieDetailsVC()
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

extension HomeVC: HomeViewModelDelegate {
    func setupTitles() {
        screen?.setupTitles(viewModel.welcomeLabelText, viewModel.welcomeButtonTitle)
    }
}

