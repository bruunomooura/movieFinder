//
//  HomeViewModelDelegateSpy.swift
//  MovieFinder
//
//  Created by Bruno Moura on 15/09/25.
//

import XCTest
@testable import MovieFinder

class HomeViewModelDelegateSpy: HomeViewModelDelegate {
    private(set) var setupTitlesCallCount = 0
    
    func setupTitles() {
        setupTitlesCallCount += 1
    }
}
