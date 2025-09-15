//
//  HomeToMovieDetailsE2ETests.swift
//  MovieFinder
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest

final class HomeToMovieDetailsE2ETests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }
}
