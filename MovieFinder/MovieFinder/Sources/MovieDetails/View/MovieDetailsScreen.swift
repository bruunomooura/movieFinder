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
        label.isHidden = false
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
    /**
     Configures the table view with a data source and delegate.
     
     - Parameter dataSourceAndDelegate: The data source and delegate for the table view.
     */
    public func setupTableView(dataSourceAndDelegate: MoviesDetailsTableViewDataSource, contentInsetTop: CGFloat) {
        tableView.delegate = dataSourceAndDelegate
        tableView.dataSource = dataSourceAndDelegate
//        tableView.contentInset = UIEdgeInsets(top: -contentInsetTop, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets.top = -(contentInsetTop * 2)
//        tableView.verticalScrollIndicatorInsets.top = -(contentInsetTop * 2)
//        tableView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.contentInsetAdjustmentBehavior = .never
//        tableView.reloadData()
//        tableView.insetsContentViewsToSafeArea = false

    }
        
//    public func updateConstraints(for traitCollection: UITraitCollection) {
//        if traitCollection.verticalSizeClass == .regular {
//            // Portrait
//            NSLayoutConstraint.deactivate(landscapeConstraints)
//            NSLayoutConstraint.activate(portraitConstraints)
//#if DEBUG
//            print("modo retrato")
//#endif
//        } else {
//            // Landscape
//            NSLayoutConstraint.deactivate(portraitConstraints)
//            NSLayoutConstraint.activate(landscapeConstraints)
//#if DEBUG
//            print("modo paisagem")
//#endif
//        }
//    }
    
    // MARK: Reload Table View
    /**
     Reloads the table view data.
     */
    public func reloadTableView() {
        tableView.reloadData()
    }
    
    
    public func insertRowsTableView(indexPaths: [IndexPath]) {
        tableView.performBatchUpdates {
            tableView.insertRows(at: indexPaths, with: .middle)
        }
    }
    
    // MARK: No Results
    /**
     Displays or hides the no results label and table view based on whether there are movies results.
     
     - Parameter noResults: A boolean indicating if there are no results.
     */
    public func noResults(noResults: Bool) {
        tableView.isHidden = noResults
        noResultsLabel.isHidden = !noResults
    }
}

extension MovieDetailsScreen: ViewCode {
    // MARK: Add Subviews
    /**
     Adds the subviews to the main view.
     */
    func addSubviews() {
        addSubview(tableView)
        addSubview(noResultsLabel)
    }
    
    // MARK: Setup Constraints
    /**
     Configures the layout constraints for the subviews.
     */
    func setupConstraints() {
    
        // Portrait Constraints
//        portraitConstraints = [
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
//        ]
        
//        // Landscape Constraints
//        landscapeConstraints = [
//           
//            tableView.topAnchor.constraint(equalTo: topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            
//            noResultsLabel.topAnchor.constraint(equalTo: topAnchor),
//            noResultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            noResultsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            noResultsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
//        ]
    }
    
    // MARK: Extra Configuration
    /**
     Additional configurations for the view.
     */
    func setupStyle() {
        backgroundColor = .clear
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
    }
}
