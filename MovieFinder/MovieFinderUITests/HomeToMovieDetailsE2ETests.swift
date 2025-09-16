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
        
        // Verifica se está na home screen
        XCTAssertTrue(homePage.logoImage.exists)
        XCTAssertTrue(homePage.welcomeLabel.exists)
        XCTAssertTrue(homePage.welcomeButton.exists)
        
        // Navega para a tela de detalhes
        homePage.tapWelcomeButton()
        
        // Verifica se chegou na tela de detalhes
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
    }
    
    func test_movieDetailsComponents_whenScreenLoads_shouldDisplayAllRequiredElements() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        // Navega para os detalhes
        homePage.tapWelcomeButton()
        
        // Verifica se a tabela existe
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        // Verifica se o poster existe
        XCTAssertTrue(movieDetailsPage.posterCell.image.exists)
        
        // Verifica se o header existe
        XCTAssertTrue(movieDetailsPage.headerCell.movieTitleLabel.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.likeButton.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.likeCountLabel.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.popularityLabel.exists)
    }
    
    func test_likeButton_whenUserTaps_shouldMaintainButtonExistence() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        // Navega para os detalhes
        homePage.tapWelcomeButton()
        
        // Aguarda o carregamento da tela
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        // Captura o botão de like
        let likeButton = movieDetailsPage.headerCell.likeButton
        XCTAssertTrue(likeButton.exists)
        
        // Toca no botão de like
        movieDetailsPage.headerCell.tapFavorite()
        
        // Verifica se o botão ainda existe após o tap
        XCTAssertTrue(likeButton.exists)
    }
    
    func test_similarMoviesSection_whenUserScrollsDown_shouldDisplaySimilarMovies() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        // Navega para os detalhes
        homePage.tapWelcomeButton()
        
        // Aguarda o carregamento
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        // Rola para baixo para ver os filmes similares
        movieDetailsPage.table.swipeUp()
        
        // Verifica se existem filmes similares
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
        
        // Navega para os detalhes
        homePage.tapWelcomeButton()
        
        // Verifica se está na tela de detalhes
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 5))
        
        // Volta para a home (assumindo que há um botão de volta)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Verifica se voltou para a home
        XCTAssertTrue(homePage.welcomeButton.waitForExistence(timeout: 5))
        XCTAssertTrue(homePage.logoImage.exists)
    }
    
    func test_noResultsState_whenNoDataAvailable_shouldDisplayNoResultsMessage() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        // Configure seu app para simular um estado de erro/sem resultados
        app.launchArguments.append("UITestingNoResults")
        app.launch()
        
        homePage.tapWelcomeButton()
        
        // Verifica se a mensagem de "sem resultados" aparece
        XCTAssertTrue(movieDetailsPage.noResultsLabel.waitForExistence(timeout: 10))
        XCTAssertTrue(movieDetailsPage.noResultsLabel.isHittable)
        XCTAssertFalse(movieDetailsPage.table.isHittable)
    }
    
    func test_completeUserFlow_whenUserNavigatesAndInteracts_shouldPerformAllActionsSuccessfully() {
        let homePage = HomeScreenPage(app: app)
        let movieDetailsPage = MovieDetailsScreenPage(app: app)
        
        // 1. Verifica tela inicial
        XCTAssertTrue(homePage.logoImage.exists)
        XCTAssertTrue(homePage.welcomeLabel.exists)
        XCTAssertTrue(homePage.welcomeButton.exists)
        
        // 2. Navega para detalhes
        homePage.tapWelcomeButton()
        
        // 3. Verifica carregamento dos detalhes
        XCTAssertTrue(movieDetailsPage.table.waitForExistence(timeout: 10))
        XCTAssertTrue(movieDetailsPage.posterCell.image.exists)
        XCTAssertTrue(movieDetailsPage.headerCell.movieTitleLabel.exists)
        
        // 4. Interage com o conteúdo
        movieDetailsPage.headerCell.tapFavorite()
        
        // 5. Explora filmes similares
        movieDetailsPage.table.swipeUp()
        
        // 6. Volta para a home
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(homePage.welcomeButton.waitForExistence(timeout: 5))
    }
}
