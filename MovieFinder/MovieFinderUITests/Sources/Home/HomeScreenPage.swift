//
//  HomeScreenPage.swift
//  MovieFinderUITests
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest

struct HomeScreenPage {
    let app: XCUIApplication
    
    var logoImage: XCUIElement { app.images["logoImageView"] }
  
    var welcomeLabel: XCUIElement { app.staticTexts["welcomeLabel"] }
    
    var welcomeButton: XCUIElement { app.buttons["welcomeButton"] }

    func tapWelcomeButton() {
        welcomeButton.tap()
    }
}
