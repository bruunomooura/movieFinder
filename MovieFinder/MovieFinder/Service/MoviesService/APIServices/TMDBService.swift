//
//  TMDBService.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

class TMDBService {
    let session: URLSession
    let decoderService: JSONDecoderService
    
    init(session: URLSession = .shared, decoderService: JSONDecoderService = JSONDecoderService()) {
        self.session = session
        self.decoderService = decoderService
    }

    func performRequest<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(APIKeys.tmdbAPIToken)"
        ]
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(description: "Invalid response")
        }
              
        guard httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else {
            throw NetworkError.serverError(code: httpResponse.statusCode)
        }
        
        do {
            return try decoderService.decode(T.self, from: data)
        } catch is DecodingError {
            throw NetworkError.decodingError
        } catch URLError.notConnectedToInternet {
            throw NetworkError.noInternet
        } catch URLError.timedOut {
            throw NetworkError.timeout
        } catch {
            throw NetworkError.unknown(description: error.localizedDescription)
        }
    }
}
