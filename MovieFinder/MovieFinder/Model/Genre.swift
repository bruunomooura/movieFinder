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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
    }
}
