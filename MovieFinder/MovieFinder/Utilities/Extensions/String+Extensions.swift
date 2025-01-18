//
//  String+Extensions.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

extension String {
    // MARK: Localized
    /// Just calling this variable to any string you can obtain its localized version.
    /// Arguments can be applied using the same SwiftUI Text() format:
    ///     "key \(argument)".localized
    var localized: String {
        if let index = self.firstIndex(of: " ") {
            let key = self.prefix(upTo: index)
            var parameter = self.suffix(from: index)
            parameter.removeFirst()
            return String(format: NSLocalizedString("\(key) %@", comment: ""), String(parameter))
        } else {
            return String(localized: LocalizationValue(self))
        }
    }
}
