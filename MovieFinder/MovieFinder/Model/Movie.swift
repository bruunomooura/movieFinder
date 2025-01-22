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
    let genreIDs: [Int]?
    let id: Int
    let popularity: Double
    var imagePath: String
    let releaseDate: String
    let title: String
    let voteCount: Double
    
    enum CodingKeys: String, CodingKey {
        case genreIDs = "genre_ids"
        case id
        case popularity
        case imagePath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteCount = "vote_count"
    }
    
    /// A computed property that generates the complete image URL.
    ///
    /// This property combines the base URL with a specified image size and the movie's image path.
    ///
    /// - Note: The image size is currently hardcoded as "w185".
    ///
    /// - Returns: A `String` representing the complete URL to access the movie's image.
    var imageURL: String {
        let imageSize = "w185"
        return APIKeys.imageBaseURL + imageSize + self.imagePath
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
            return "Error"
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
