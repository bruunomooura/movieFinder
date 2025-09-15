//
//  Movie.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation


struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let backdropPath: String
    let genreIDs: [Int]?
    let id: Int
    let popularity: Double
    var posterPath: String
    let releaseDate: String
    let title: String
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteCount = "vote_count"
    }
    
    init(
        backdropPath: String,
        genreIDs: [Int]?,
        id: Int,
        popularity: Double,
        posterPath: String,
        releaseDate: String,
        title: String,
        voteCount: Int
    ) {
        self.backdropPath = backdropPath
        self.genreIDs = genreIDs
        self.id = id
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteCount = voteCount
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        genreIDs = try container.decodeIfPresent([Int]?.self, forKey: .genreIDs) ?? nil
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        
        if let popularityValue = try? container.decode(Double.self, forKey: .popularity) {
            popularity = popularityValue * 1000
        } else {
            popularity = 0.0
        }
    }
    
    func imageURL(size: TMDBImageSize = .w185, pathImage: TMDBImagePath = .posterPath) -> String {
        switch pathImage {
        case .backdropPath:
            guard !self.backdropPath.isEmpty else {
                return ""
            }
            return APIKeys.imageBaseURL + size.rawValue + self.backdropPath
        case .posterPath:
            guard !self.posterPath.isEmpty else {
                return ""
            }
            return APIKeys.imageBaseURL + size.rawValue + self.posterPath
        }
    }
    
    var releaseYear: String {
        return releaseDate.extractYear(fromFormat: "yyyy-MM-dd")
    }
    
    func genreNames(using mappingGenres: [Int: String]) -> String {
        guard let genreIDs = self.genreIDs, !genreIDs.isEmpty else {
            return ""
        }
        if genreIDs.count == 1 {
            let genre = genreIDs.prefix(1).compactMap { mappingGenres[$0] }
            return genre[0]
        } else {
            let genres = genreIDs.prefix(2).compactMap { mappingGenres[$0] }
            return "\(genres[0]), \(genres[1])"
        }
    }
}

extension Movie {
    static func with(
        movie: Movie = Movie(
            backdropPath: "/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg",
            genreIDs: [16, 12, 14],
            id: 939243,
            popularity: 2596.305,
            posterPath: "/8HzA55GCjRTEC2YhPGna8Lc8qHo.jpg",
            releaseDate: "2024-12-19",
            title: "Sonic 3: O Filme",
            voteCount: 638)
    ) -> Movie {
        return movie
    }
}
