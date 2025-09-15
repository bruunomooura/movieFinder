//
//  Genre.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

// MARK: - Genres
struct GenreResponse: Codable {
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
    
    init(
        genres: [Genre]
    ) {
        self.genres = genres
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
    }
}

extension GenreResponse {
    static func with(
        genreResponse: GenreResponse = GenreResponse(
            genres: [Genre(id: 28, name: "Ação"),
                     Genre(id: 12, name: "Aventura"),
                     Genre(id: 16, name: "Animação"),
                     Genre(id: 35, name: "Comédia")]
        )
    ) -> GenreResponse {
        return genreResponse
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
    }
}

extension Genre {
    static func with(
        genre: Genre = Genre(id: 28, name: "Ação")
    ) -> Genre {
        return genre
    }
}
