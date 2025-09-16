//
//  HomeToMovieDetailsE2ETests.swift
//  MovieFinderUITests
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest

final class HomeToMovieDetailsE2ETests: XCTestCase {
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
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
    
    func test_navigation_whenUserTapsWelcomeButton_shouldDdisplayMovieDetailsScreen() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        XCTAssertTrue(homePage.logoImage.exists)
        XCTAssertTrue(homePage.welcomeLabel.exists)
        XCTAssertTrue(homePage.welcomeButton.exists)
        
        homePage.tapWelcomeButton()
        
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
    }
    
    func test_movieDetailsComponents_whenScreenLoads_shouldDisplayAllRequiredElements() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        homePage.tapWelcomeButton()
        
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        XCTAssertTrue(movieDetailsPage.posterCell.image.exists)
        
        XCTAssertTrue(movieDetailsPage.headerCell.movieTitleLabel.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.likeButton.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.likeCountLabel.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.popularityLabel.exists)
    }
    
    func test_likeButton_whenUserTaps_shouldMaintainButtonExistence() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        homePage.tapWelcomeButton()
        
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        let likeButton = movieDetailsPage.headerCell.likeButton
        XCTAssertTrue(likeButton.exists)
        
        movieDetailsPage.headerCell.tapFavorite()
        
        XCTAssertTrue(likeButton.exists)
    }
    
    func test_similarMoviesSection_whenUserScrollsDown_shouldDisplaySimilarMovies() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        homePage.tapWelcomeButton()
        
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        movieDetailsPage.table.swipeUp()
        
        if !movieDetailsPage.similarCells.isEmpty {
            let firstSimilarMovie = movieDetailsPage.similarCells[0]
            XCTAssertTrue(firstSimilarMovie.poster.exists)
            XCTAssertTrue(firstSimilarMovie.title.exists)
            XCTAssertTrue(firstSimilarMovie.releaseYear.exists)
            XCTAssertTrue(firstSimilarMovie.genres.exists)
        }
    }
    
    func test_backNavigation_whenUserNavigatesBack_shouldReturnToHomeScreen() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        homePage.tapWelcomeButton()
        
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        XCTAssertTrue(homePage.welcomeButton.waitForExistence(timeout: 5))
        XCTAssertTrue(homePage.logoImage.exists)
    }
    
    func test_noResultsState_whenNoDataAvailable_shouldDisplayNoResultsMessage() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        app.launchArguments.append("UITestingNoResults")
        app.launch()
        
        homePage.tapWelcomeButton()
        
        XCTAssertTrue(movieDetailsPage.noResultsLabel.waitForExistence(timeout: 10))
        XCTAssertTrue(movieDetailsPage.noResultsLabel.isHittable)
        XCTAssertFalse(movieDetailsPage.table.isHittable)
    }
    
    func test_completeUserFlow_whenUserNavigatesAndInteracts_shouldPerformAllActionsSuccessfully() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        XCTAssertTrue(homePage.logoImage.exists)
        XCTAssertTrue(homePage.welcomeLabel.exists)
        XCTAssertTrue(homePage.welcomeButton.exists)
        
        homePage.tapWelcomeButton()
        
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 10))
        XCTAssertTrue(movieDetailsPage.posterCell.image.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.movieTitleLabel.exists)
        
        movieDetailsPage.headerCell.tapFavorite()
        
        movieDetailsPage.table.swipeUp()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(homePage.welcomeButton.waitForExistence(timeout: 5))
    }
}
