//
//  AppConfig.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class AppConfig {
    static let currentDevelopmentStatus: DevelopmentStatus = {
#if DEBUG
        return .development
#else
        return .production
#endif
    }()
}
