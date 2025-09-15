//
//  MovieDetailsVC.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

class MovieDetailsVC: UIViewController {
    let viewModel: MovieDetailsViewModelProtocol
    let screen: MovieDetailsScreen
    var customAlert: CustomAlert?
    private var tableViewDataSource: MoviesDetailsTableViewDataSource?
    
    init(viewModel: MovieDetailsViewModelProtocol = MovieDetailsViewModel(),
         screen: MovieDetailsScreen = MovieDetailsScreen(),
         tableViewDataSource: MoviesDetailsTableViewDataSource = MoviesDetailsTableViewDataSource()) {
        self.viewModel = viewModel
        self.screen = screen
        self.tableViewDataSource = tableViewDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViewModel()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDataSecondary()
    }
    
    override func loadView() {
        view = screen
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

// MARK: - Functions for initial setup
extension MovieDetailsVC {
    
    // MARK: - Navigation Bar Setup
    /// Configures the navigation bar appearance and title.
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let config = UIImage.SymbolConfiguration(paletteColors: [.white, .black.withAlphaComponent(0.45)])
        let image = UIImage(systemName: SystemImage.chevronLeftCircleFill.rawValue, withConfiguration: config)
        
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.accessibilityTraits = .none
    }
    
    // MARK: - ViewModel Configuration
    /// Configures the ViewModel by setting the delegate and initiating the data loading process.
    private func setupViewModel() {
        viewModel.delegate = self
        loadDataPrimary()
    }
    
    // MARK: - Data Loading
    /// Asynchronously loads primary movie data.
    private func loadDataPrimary() {
        Task {
            await viewModel.loadMovieDetails()
        }
    }
    
    // MARK: - Data Loading
    /// Asynchronously loads secondary movie data, including genres and similar movies.
    private func loadDataSecondary() {
        Task {
            await viewModel.loadGenresAndSimilarMovies()
        }
    }
    
    // MARK: - TableView Setup
    /// Initializes and configures the TableView DataSource and connects it to the screen.
    private func setupTableView() {
        tableViewDataSource?.delegateMovieHeader = self
        guard let dataSource = tableViewDataSource else { return }
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        screen.setupTableView(dataSourceAndDelegate: dataSource, contentInsetTop: navigationBarHeight)
    }
}

// MARK: - MovieHeaderTableViewCellDelegate
extension MovieDetailsVC: MovieHeaderTableViewCellDelegate {
    /// Called when the like button is selected.
    ///
    /// - Parameter sender: The UIButton that triggered the event.
    func didSelectedLikeButton(_ sender: UIButton) {
        screen.reloadTableView()
    }
}

// MARK: - MovieDetailsViewModelDelegate
extension MovieDetailsVC: MovieDetailsViewModelDelegate {
    /// Called when movie details are successfully loaded.
    ///
    /// - Parameter movieDetails: The Movie object containing the loaded details.
    func loadMovieDetailsSuccess(movieDetails: Movie?) {
        tableViewDataSource?.setupInitialData(movieDetails: movieDetails)
        screen.noResults(noResults: false)
        screen.reloadTableView()
    }
    
    /// Called when genres and similar movies are successfully loaded.
    ///
    /// - Parameters:
    ///   - genresDictionary: A dictionary of genre IDs and their corresponding names.
    ///   - similarMovies: An array of similar movies.
    ///   - indexPath: The index paths of the rows to be inserted.
    func loadGenresAndSimilarMoviesSuccess(genresDictionary: [Int : String], similarMovies: [Movie], _ indexPath: [IndexPath]) {
        tableViewDataSource?.setupSecondaryData(genresDictionary: genresDictionary,
                                                similarMovies: similarMovies)
        screen.noResults(noResults: false)
        screen.insertRowsTableView(indexPaths: indexPath)
    }
    
    /// Called when there is an error loading data.
    ///
    /// - Parameter message: The error message to be displayed.
    func errorLoadingData(message: String) {
        screen.noResults(noResults: true)
        if customAlert == nil {
            customAlert = CustomAlert(parentView: self.view)
        }
        
        customAlert?.showAlert(title: "Connection Error", message: message)
    }
    
    func showNoSimilarMoviesFound() {
        screen.noResults(noResults: true)
    }
}
