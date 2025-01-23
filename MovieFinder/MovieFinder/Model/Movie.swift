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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        genreIDs = try container.decodeIfPresent([Int]?.self, forKey: .genreIDs) ?? nil
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
    }
    
    /// Generates the complete URL for the movie's image based on its type (poster or backdrop).
    ///
    /// This function combines the base image URL, a specified image size, and the corresponding image path (either `backdropPath` or `posterPath`) of the movie.
    ///
    /// - Parameters:
    ///   - size: The desired image size. The default value is `.w185`, which corresponds to a specific image resolution.
    ///   - pathImage: The type of image path to use, either `.backdropPath` or `.posterPath`. The default is `.posterPath`.
    ///
    /// - Note: If the specified image path is empty, the function will return an empty string.
    /// - Note: The image size is currently hardcoded as `w185`, but it can be changed by passing a different value to the `size` parameter.
    ///
    /// - Returns: A `String` representing the complete URL to access the movie's image. Returns an empty string if the image path is empty.
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
    
    /// Translates genre IDs to their corresponding genre names.
    ///
    /// This function takes a dictionary mapping genre IDs to their corresponding genre names and returns a `String`
    /// containing the genre names associated with the first two genre IDs in the given array. If the `genreIDs`
    /// property is `nil` or empty, it returns an error message.
    ///
    /// - Parameter mappingGenres: A dictionary where the keys are `Int` genre IDs and the values are `String` genre names.
    /// - Returns: A `String` representing the genre names associated with the first two genre IDs. If only one genre ID
    ///   exists, it returns the name of that genre. If no genre IDs exist, it returns `"Error"`.
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
