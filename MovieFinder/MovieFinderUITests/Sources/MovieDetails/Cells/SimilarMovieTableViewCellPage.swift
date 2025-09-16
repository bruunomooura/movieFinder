//
//  SimilarMovieTableViewCellPage.swift
//  MovieFinder
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest

struct SimilarMovieTableViewCellPage {
    let cell: XCUIElement
    
    var poster: XCUIElement { cell.images["similarMovieCell.poster"] }
    var title: XCUIElement { cell.staticTexts["similarMovieCell.title"] }
    var releaseYear: XCUIElement { cell.staticTexts["similarMovieCell.releaseYear"] }
    var genres: XCUIElement { cell.staticTexts["similarMovieCell.genres"] }
}
