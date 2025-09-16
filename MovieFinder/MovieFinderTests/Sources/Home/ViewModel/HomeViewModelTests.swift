//
//  HomeViewModelTests.swift
//  MovieFinder
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest
@testable import MovieFinder

final class HomeViewModelTests: XCTestCase {
    private var delegateSpy: HomeViewModelDelegateSpy!
    private var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        delegateSpy = HomeViewModelDelegateSpy()
        sut = HomeViewModel()
        sut.delegate = delegateSpy
    }
    
    override func tearDown() {
        delegateSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func test_setupTitles_whenCalled_shouldCallDelegate() {
        // Arrange
        
        // Act
        sut.setupTitles()
        
        // Assert
        XCTAssertEqual(delegateSpy.setupTitlesCallCount, 1)
    }
    
    func test_welcomeLabelText_shouldReturnLocalizedValue() {
        XCTAssertEqual(sut.welcomeLabelText, "home.description".localized)
    }

    func test_welcomeButtonTitle_shouldReturnLocalizedValue() {
        XCTAssertEqual(sut.welcomeButtonTitle, "home.button.title".localized)
    }
}
