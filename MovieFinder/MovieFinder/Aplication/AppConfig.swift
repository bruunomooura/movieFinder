//
//  AppConfig.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

/// A configuration class for setting up the application's service factory.
///
/// This class determines whether to use the development or production service factory
/// based on the build configuration. It provides a static property `serviceFactory`
/// that returns an instance of `ServiceFactoryProtocol`.
final class AppConfig {
    
    /// A static property that returns the appropriate service factory
    /// based on the current build configuration.
    ///
    /// - Returns: An instance of a type conforming to `ServiceFactoryProtocol`.
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
