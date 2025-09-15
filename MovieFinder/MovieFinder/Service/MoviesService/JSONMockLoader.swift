//
//  JSONMockLoader.swift
//  MovieFinder
//
//  Created by Bruno Moura on 04/09/25.
//

import Foundation

protocol MockLoaderProtocol {
    func load<T: Decodable>(_ filename: String, as type: T.Type) throws -> T
}

class DefaultJSONMockLoader: MockLoaderProtocol {
    private let bundle: Bundle
    private let decoderService: JSONDecoderService
    
    init(bundle: Bundle = .main,
         decoderService: JSONDecoderService = JSONDecoderService()) {
        self.bundle = bundle
        self.decoderService = decoderService
    }
    
    func load<T>(_ filename: String, as type: T.Type) throws -> T where T : Decodable {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw MockLoaderError.fileNotFound(filename)
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try decoderService.decode(T.self, from: data)
        } catch is DecodingError {
            throw MockLoaderError.decodingError
        } catch {
            throw NetworkError.unknown(description: error.localizedDescription)
        }
    }
}
