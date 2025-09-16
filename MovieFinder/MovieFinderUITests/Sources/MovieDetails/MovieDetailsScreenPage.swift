//
//  MovieDetailsScreenPage.swift
//  MovieFinderUITests
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest

struct MovieDetailsScreenPage {
    let app: XCUIApplication
    
    var table: XCUIElement {
        app.tables["movieDetailsTableView"]
    }
    
    var posterCell: MoviePosterTableViewCellPage {
        MoviePosterTableViewCellPage(cell: table.cells.element(boundBy: 0))
    }
    
    var headerCell: MovieHeaderTableViewCellPage {
        MovieHeaderTableViewCellPage(cell: table.cells.element(boundBy: 1))
    }
    
    var similarCells: [SimilarMovieTableViewCellPage] {
        let cells = table.cells.allElementsBoundByIndex.dropFirst(2)
        return cells.map { SimilarMovieTableViewCellPage(cell: $0) }
    }
    
    var noResultsLabel: XCUIElement {
        app.staticTexts["noResultsLabel"]
    }
}
