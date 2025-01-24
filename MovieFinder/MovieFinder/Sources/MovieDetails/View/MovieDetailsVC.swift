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
    
    override func viewDidAppear(_ animated: Bool) {
        loadDataSecondary()
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
        let config = UIImage.SymbolConfiguration(paletteColors: [.white, .black.withAlphaComponent(0.45)])
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
        loadDataPrimary()
    }
    
    // MARK: - Data Loading
    /// Async loads movie data.
    private func loadDataPrimary() {
        Task {
            await viewModel.loadMovieDetails()
        }
    }
    
    // MARK: - Data Loading
    /// Async loads movie data.
    private func loadDataSecondary() {
        Task {
            await viewModel.loadGenresAndSimilarMovies()
        }
    }
    
    // MARK: - TableView Setup
    /// Initializes and configures the TableView DataSource and connects it to the screen.
    private func setupTableView() {
        tableViewDataSource = MoviesDetailsTableViewDataSource()
        tableViewDataSource?.delegateMovieHeader = self
        guard let dataSource = tableViewDataSource else { return }
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        screen?.setupTableView(dataSourceAndDelegate: dataSource, contentInsetTop: navigationBarHeight)
    }
}

extension MovieDetailsVC: MovieHeaderTableViewCellDelegate {
    func didSelectedLikeButton(_ sender: UIButton) {
        screen?.reloadTableView()
    }
}

extension MovieDetailsVC: MovieDetailsViewModelDelegate {
    func loadMovieDetailsSuccess(movieDetails: Movie?) {
        tableViewDataSource?.setupInitialData(movieDetails: movieDetails)
        screen?.noResults(noResults: false)
        screen?.reloadTableView()
    }
    
    func loadGenresAndSimilarMoviesSuccess(genresDictionary: [Int : String], similarMovies: [Movie], _ indexPath: [IndexPath] ) {
        tableViewDataSource?.setupSecondaryData(genresDictionary: genresDictionary,
                                             similarMovies: similarMovies)
        screen?.noResults(noResults: false)
        screen?.insertRowsTableView(indexPaths: indexPath)
    }
    
    func errorLoadingData(message: String) {
        screen?.noResults(noResults: true)
//        if customAlert == nil {
            customAlert = CustomAlert(parentView: self.view)
//        }
        
        customAlert?.showAlert(title: "Erro de conexão", message: "Cheque sua conexão com a internet. themoviedb.org também pode estar indisponível")
    }
//    func updateData(content: [Movie]) {
//        <#code#>
//    }
    
    
    
}

