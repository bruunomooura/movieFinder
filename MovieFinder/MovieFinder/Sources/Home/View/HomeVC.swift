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
        screen?.updateConstraints(for: traitCollection)
        viewModel.delegate(delegate: self)
        viewModel.setupTitles()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.screen =  HomeScreen()
        view = screen
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        screen?.updateConstraints(for: traitCollection)
    }

    deinit {
        print(Self.self, "- Deallocated")
    }
}

extension HomeVC: HomeScreenDelegate {
    func didTapWelcomeButton() {
        print("botão tocado")
    }
}

extension HomeVC: HomeViewModelDelegate {
    func setupTitles() {
        screen?.setupTitles(viewModel.welcomeLabelText, viewModel.welcomeButtonTitle)
    }
}

