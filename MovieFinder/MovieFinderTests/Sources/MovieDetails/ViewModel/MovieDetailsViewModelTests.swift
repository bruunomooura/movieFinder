//
//  MovieDetailsViewModelTests.swift
//  MovieFinderTests
//
//  Created by Bruno Moura on 04/09/25.
//

import XCTest
@testable import MovieFinder

final class MovieDetailsViewModelTests: XCTestCase {
    
    private var genreServiceMock: MockGenreService!
    private var movieDetailsServiceMock: MockMovieDetailsService!
    private var similarMoviesServiceMock: MockSimilarMoviesService!
    
    private var delegateSpy: MovieDetailsViewModelDelegateSpy!
    private var sut: MovieDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        genreServiceMock = MockGenreService()
        movieDetailsServiceMock = MockMovieDetailsService()
        similarMoviesServiceMock = MockSimilarMoviesService()
        delegateSpy = MovieDetailsViewModelDelegateSpy()
        
        sut = MovieDetailsViewModel(
            genreServiceProtocol: genreServiceMock,
            movieDetailsServiceProtocol: movieDetailsServiceMock,
            similarMoviesServiceProtocol: similarMoviesServiceMock
        )
        sut.delegate = delegateSpy
    }
    
    override func tearDown() {
        genreServiceMock = nil
        movieDetailsServiceMock = nil
        similarMoviesServiceMock = nil
        delegateSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func test_loadMovieDetails_shouldToggleIsLoadingProperly() async {
        // Arrange
        let dummyMovie = Movie.with()
        movieDetailsServiceMock.result = .success(dummyMovie)
        
        // Act
        await sut.loadMovieDetails()
        
        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(delegateSpy.loadMovieDetailsSuccessCallCount, 1)
    }
    
    func test_loadMovieDetails_whenServiceReturnsSuccess_shouldCallDelegateWithMovie() async {
        // Arrange
        let dummyMovie = Movie.with()
        movieDetailsServiceMock.result = .success(dummyMovie)
        
        // Act
        await sut.loadMovieDetails()
        
        // Assert
        XCTAssertEqual(delegateSpy.loadMovieDetailsSuccessCallCount, 1)
        XCTAssertNotNil(delegateSpy.receivedMovieDetails)
        XCTAssertEqual(delegateSpy.receivedMovieDetails?.id, 939243)
        XCTAssertEqual(delegateSpy.errorLoadingDataCallCount, 0)
    }
    
    func test_loadMovieDetails_whenServiceThrowsError_shouldCallDelegateWithError() async {
        // Arrange
        let expectedError = NetworkError.noInternet
        movieDetailsServiceMock.result = .failure(expectedError)
        
        // Act
        await sut.loadMovieDetails()
        
        // Assert
        XCTAssertEqual(delegateSpy.errorLoadingDataCallCount, 1)
        XCTAssertEqual(delegateSpy.receivedErrorMessage, expectedError.localizedDescription)
        XCTAssertEqual(delegateSpy.loadMovieDetailsSuccessCallCount, 0)
    }
    
    
    func test_loadGenresAndSimilarMovies_shouldToggleIsLoadingProperly() async {
        // Arrange
        let dummyGenres = GenreResponse.with()
        let dummySimilarMovies = MovieResponse(results: [Movie.with(), Movie.with()])
        
        genreServiceMock.result = .success(dummyGenres)
        similarMoviesServiceMock.result = .success(dummySimilarMovies)
        
        // Act
        await sut.loadGenresAndSimilarMovies()
        
        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(delegateSpy.loadGenresAndSimilarMoviesSuccessCallCount, 1)
    }
    
    func test_loadGenresAndSimilarMovies_whenServicesReturnSuccess_shouldCallDelegateWithData() async {
        // Arrange
        let dummyGenres = GenreResponse.with()
        let dummySimilarMovies = MovieResponse(results: [Movie.with(), Movie.with()])
        
        genreServiceMock.result = .success(dummyGenres)
        similarMoviesServiceMock.result = .success(dummySimilarMovies)
        
        // Act
        await sut.loadGenresAndSimilarMovies()
        
        // Assert
        XCTAssertEqual(delegateSpy.receivedGenresDictionary?[28], "Ação")
        XCTAssertEqual(delegateSpy.receivedGenresDictionary?[12], "Aventura")
        XCTAssertEqual(delegateSpy.receivedGenresDictionary?[16], "Animação")
        XCTAssertEqual(delegateSpy.receivedGenresDictionary?[35], "Comédia")
        XCTAssertEqual(delegateSpy.receivedGenresDictionary?.count, 4)
        XCTAssertEqual(delegateSpy.receivedIndexPath, [IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0)])
        XCTAssertEqual(delegateSpy.receivedSimilarMovies?.count, 2)
        XCTAssertEqual(delegateSpy.receivedSimilarMovies?.first?.id, 939243)
    }
    
    func test_loadGenresAndSimilarMovies_defineIndexPathWithMultipleMovies() async {
        // Arrange
        let dummyGenres = GenreResponse.with()
        let dummySimilarMovies = MovieResponse(results:
                                                [Movie.with(),
                                                 Movie(
                                                    backdropPath: "/g67r1eiQD3ERSEQFCFkSn7TeGw5.jpg",
                                                    genreIDs: [12],
                                                    id: 775,
                                                    popularity: 14.616,
                                                    posterPath: "/9o0v5LLFk51nyTBHZSre6OB37n2.jpg",
                                                    releaseDate: "1902-06-21",
                                                    title: "A Trip to the Moon",
                                                    voteCount: 1801)])
        
        genreServiceMock.result = .success(dummyGenres)
        similarMoviesServiceMock.result = .success(dummySimilarMovies)
        
        // Act
        await sut.loadGenresAndSimilarMovies()
        
        // Assert
        let expectedIndexPaths = (0..<2).map { IndexPath(row: $0 + 2, section: 0) }
        XCTAssertEqual(delegateSpy.receivedIndexPath, expectedIndexPaths)
    }
    
    func test_loadGenresAndSimilarMovies_whenSimilarMoviesReturnsEmpty_shouldCallDelegateWithEmptyArray() async {
        // Arrange
        let dummyGenres = GenreResponse.with()
        let emptySimilarMovies = MovieResponse(results: [])
        
        genreServiceMock.result = .success(dummyGenres)
        similarMoviesServiceMock.result = .success(emptySimilarMovies)
        
        // Act
        await sut.loadGenresAndSimilarMovies()
        
        // Assert
        XCTAssertEqual(delegateSpy.showNoSimilarMoviesFoundCallCount, 1)
        XCTAssertEqual(delegateSpy.loadGenresAndSimilarMoviesSuccessCallCount, 0)
        XCTAssertEqual(delegateSpy.errorLoadingDataCallCount, 0)
    }
    
    func test_loadGenresAndSimilarMovies_whenSimilarMoviesServiceThrowsError_shouldCallDelegateWithError() async {
        // Arrange
        let dummyGenres = GenreResponse.with()
        let expectedError = NetworkError.serverError(code: 500)
        
        genreServiceMock.result = .success(dummyGenres)
        similarMoviesServiceMock.result = .failure(expectedError)
        
        // Act
        await sut.loadGenresAndSimilarMovies()
        
        // Assert
        XCTAssertEqual(delegateSpy.errorLoadingDataCallCount, 1)
        XCTAssertEqual(delegateSpy.loadGenresAndSimilarMoviesSuccessCallCount, 0)
        XCTAssertEqual(delegateSpy.showNoSimilarMoviesFoundCallCount, 0)
        XCTAssertEqual(delegateSpy.receivedErrorMessage, expectedError.localizedDescription)
        XCTAssertNil(delegateSpy.receivedGenresDictionary)
        XCTAssertNil(delegateSpy.receivedSimilarMovies)
        XCTAssertNil(delegateSpy.receivedIndexPath)
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_loadGenresAndSimilarMovies_whenGenresServiceThrowsError_shouldCallDelegateWithError() async {
        // Arrange
        let expectedError = NetworkError.serverError(code: 500)
        
        genreServiceMock.result = .failure(expectedError)
        similarMoviesServiceMock.result = .success(MovieResponse.init(results: []))
        
        // Act
        await sut.loadGenresAndSimilarMovies()
        
        // Assert
        XCTAssertEqual(delegateSpy.errorLoadingDataCallCount, 1)
        XCTAssertEqual(delegateSpy.loadMovieDetailsSuccessCallCount, 0)
        XCTAssertEqual(delegateSpy.receivedErrorMessage, expectedError.localizedDescription)
        XCTAssertEqual(delegateSpy.showNoSimilarMoviesFoundCallCount, 0)
        XCTAssertNil(delegateSpy.receivedGenresDictionary)
        XCTAssertNil(delegateSpy.receivedSimilarMovies)
        XCTAssertNil(delegateSpy.receivedIndexPath)
        XCTAssertFalse(sut.isLoading)
    }
}
