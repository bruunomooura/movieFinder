//
//  MovieDetailsVC.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    var viewModel: MovieDetailsViewModel = MovieDetailsViewModel()
    var screen: MovieDetailsScreen?
    var customAlert: CustomAlert?
    private var tableViewDataSource: MoviesDetailsTableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViewModel()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.screen = MovieDetailsScreen()
        view = screen
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

// MARK: - Functions for initial setup
extension MovieDetailsVC {
    // MARK: - Navigation Bar Setup
    /**
     Configures the navigation bar appearance and title.
     */
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let config = UIImage.SymbolConfiguration(paletteColors: [.white, .systemGray5.withAlphaComponent(0.55)])
        let image = UIImage(systemName: SystemImage.chevronLeftCircleFill.rawValue, withConfiguration: config)
        
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    
    // MARK: - ViewModel Configuration
    /// Configures the ViewModel by setting the delegate and initiating the data loading process.
    private func setupViewModel() {
        viewModel.delegate(delegate: self)
        loadData()
    }
    
    // MARK: - Data Loading
    /// Async loads movie data.
    private func loadData() {
        Task {
            await viewModel.loadData()
        }
    }
    
    // MARK: - TableView Setup
    /// Initializes and configures the TableView DataSource and connects it to the screen.
    private func setupTableView() {
        tableViewDataSource = MoviesDetailsTableViewDataSource()
//        tableViewDataSource?.delegate = self
        guard let dataSource = tableViewDataSource else { return }
        screen?.setupTableView(dataSource)
    }
}

extension MovieDetailsVC: MovieDetailsViewModelDelegate {
    func errorLoadingData(message: String) {
        screen?.noResults(noResults: true)
//        if customAlert == nil {
            customAlert = CustomAlert(parentView: self.view)
//        }
        
        customAlert?.showAlert(title: "Erro de conexão", message: "Cheque sua conexão com a internet. themoviedb.org também pode estar indisponível")
    }
    
    func loadDataCompleted(genresDictionary: [Int : String], movieDetails: Movie?, similarMovies: [Movie]) {
        tableViewDataSource?.reloadTableView(genresDictionary: genresDictionary,
                                             movieDetails: movieDetails,
                                             similarMovies: similarMovies)
        screen?.noResults(noResults: false)
        screen?.reloadTableView()
    }
    
//    func updateData(content: [Movie]) {
//        <#code#>
//    }
    
    
    
}

