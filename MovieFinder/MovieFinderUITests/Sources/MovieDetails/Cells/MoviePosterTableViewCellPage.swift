//
//  MoviePosterTableViewCellPage.swift
//  MovieFinder
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest

struct MoviePosterTableViewCellPage {
    let cell: XCUIElement
    
    var image: XCUIElement { cell.images["moviePosterImageView"] }
}
