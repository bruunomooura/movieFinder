//
//  MockGenreService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class MockGenreService: GenreServiceProtocol {
    var result: Result<GenreResponse, Error>
    
    init(result: Result<GenreResponse, Error>) {
        self.result = result
    }
    
    convenience init() {
        do {
            let genres = try DefaultJSONMockLoader().load(
                JSONFile.genresData.rawValue,
                as: GenreResponse.self)
            self.init(result: .success(genres))
        } catch {
            self.init(result: .failure(error))
        }
    }
    
    public func fetchGenres(language: String) async throws -> GenreResponse {
        return try result.get()
    }
}
