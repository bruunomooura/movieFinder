//
//  JSONDecoderService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

/// A service for decoding JSON data into Swift types using `JSONDecoder`.
final class JSONDecoderService {
    
    /// Decodes the provided data into the specified type.
    ///
    /// - Parameters:
    ///   - type: The type of the object to decode, which must conform to `Decodable`.
    ///   - data: The `Data` object containing the JSON data to decode.
    /// - Returns: An instance of the specified type `T` populated with the decoded data.
    /// - Throws: An error if the decoding process fails.
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
