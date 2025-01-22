//
//  AppConfig.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

final class AppConfig {
    static let serviceFactory: ServiceFactoryProtocol = {
#if DEBUG
        print("Development mode")
        return DevelopmentServiceFactory()
#else
        print("Production mode")
        return ProductionServiceFactory()
#endif
    }()
}
