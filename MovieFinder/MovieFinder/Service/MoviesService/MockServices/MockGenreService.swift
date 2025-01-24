//
//  MockGenreService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class MockGenreService: GenreServiceProtocol {
    private let decoderService: JSONDecoderService
    
    init(decoderService: JSONDecoderService = JSONDecoderService()) {
        self.decoderService = decoderService
    }
    
    // Fetches genres from a local JSON file for testing or mocking purposes.
    ///
    /// - Parameter language: A string representing the language for the genre list (not used in this implementation).
    /// - Returns: A `GenreResponse` object containing the fetched genres.
    /// - Throws: An error of type `GenreLoadingError` if the JSON file cannot be found or if an error occurs during data loading or decoding.
    func fetchGenres(language: String) async throws -> GenreResponse {
        guard let url = Bundle.main.url(forResource: JSONFile.genresData.rawValue, withExtension: JSONFile.json.rawValue) else { throw GenreLoadingError.errorReceivingData }
        
        do {
            let data = try Data(contentsOf: url)
            let genres: GenreResponse = try decoderService.decode(GenreResponse.self, from: data)
            return genres
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
}

// Enum that represents the possible errors that may occur when loading an gender
enum GenreLoadingError: Swift.Error {
    case errorReceivingData
}
