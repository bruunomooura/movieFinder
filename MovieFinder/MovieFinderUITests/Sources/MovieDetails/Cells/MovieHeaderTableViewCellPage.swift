//
//  MovieHeaderTableViewCellPage.swift
//  MovieFinder
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest

struct MovieHeaderTableViewCellPage {
    let cell: XCUIElement
    
    var movieTitleLabel: XCUIElement { cell.staticTexts["movieTitleLabel"] }
    
    var likeButton: XCUIElement { cell.buttons["likeButton"] }
    var likeCountLabel: XCUIElement { cell.staticTexts["likeCount.label"] }
    var likeCountIcon: XCUIElement { cell.images["likeCount.icon"] }
    
    var popularityLabel: XCUIElement { cell.staticTexts["popularityCount.label"] }
    var popularityIcon: XCUIElement { cell.images["popularityCount.icon"] }
    
    func tapFavorite() {
        likeButton.tap()
    }
}
