//
//  MovieDetailsScreen.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

class MovieDetailsScreen: UIView {
    
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.isHidden = true
        tableView.register(MoviePosterTableViewCell.self, forCellReuseIdentifier: MoviePosterTableViewCell.identifier)
        tableView.register(MovieHeaderTableViewCell.self, forCellReuseIdentifier: MovieHeaderTableViewCell.identifier)
        tableView.register(SimilarMovieTableViewCell.self, forCellReuseIdentifier: SimilarMovieTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var noResultsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "movieDetails.title.noResults".localized
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .background
        label.isHidden = true
        label.accessibilityLabel = "movieDetails.noResultsLabel.accessibilityLabel".localized
        return label
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

// MARK: - Functions
extension MovieDetailsScreen {
    // MARK: Setup Table View
    /// Configures the table view with a data source and delegate.
    ///
    /// - Parameters:
    ///   - dataSourceAndDelegate: The data source and delegate for the table view.
    ///   - contentInsetTop: The top content inset for the table view.
    public func setupTableView(dataSourceAndDelegate: MoviesDetailsTableViewDataSource, contentInsetTop: CGFloat) {
        tableView.delegate = dataSourceAndDelegate
        tableView.dataSource = dataSourceAndDelegate
        tableView.scrollIndicatorInsets.top = -(contentInsetTop * 2)
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: Reload Table View
    /// Reloads the table view data.
    public func reloadTableView() {
        tableView.reloadData()
    }
    
    /// Inserts rows into the table view at the specified index paths.
    ///
    /// - Parameter indexPaths: An array of index paths indicating where to insert rows.
    public func insertRowsTableView(indexPaths: [IndexPath]) {
        tableView.performBatchUpdates {
            tableView.insertRows(at: indexPaths, with: .middle)
        }
    }
    
    // MARK: No Results
    /// Displays or hides the no results label and table view based on whether there are movie results.
    ///
    /// - Parameter noResults: A boolean indicating if there are no results.
    public func noResults(noResults: Bool) {
        tableView.isHidden = noResults
        noResultsLabel.isHidden = !noResults
    }
}

// MARK: - ViewCode Protocol Conformance
extension MovieDetailsScreen: ViewCode {
    
    // MARK: Add Subviews
    /// Adds the subviews to the main view.
    func addSubviews() {
        addSubview(tableView)
        addSubview(noResultsLabel)
    }
    
    // MARK: Setup Constraints
    /// Configures the layout constraints for the subviews.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noResultsLabel.topAnchor.constraint(equalTo: topAnchor),
            noResultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            noResultsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            noResultsLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: Extra Configuration
    /// Additional configurations for the view.
    func setupStyle() {
        backgroundColor = .clear
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
    }
}
