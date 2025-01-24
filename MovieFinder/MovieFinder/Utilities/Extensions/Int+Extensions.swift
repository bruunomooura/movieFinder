//
//  Int+Extensions.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

extension Int {
    /// Formats an integer as an abbreviated string.
    ///
    /// This function converts the integer into a more readable format:
    /// - Values equal to or greater than 1,000,000 will be represented in millions (M).
    /// - Values equal to or greater than 1,000 will be represented in thousands (k).
    /// - Values less than 1,000 will be returned as-is.
    ///
    /// - Returns: A string representing the abbreviated format of the integer.
    func formatAsAbbreviated() -> String {
        if self >= 1_000_000 {
            let formatted = Double(self) / 1_000_000
            return String(format: "%.1fM", formatted)
        } else if self >= 1_000 {
            let formatted = Double(self) / 1_000
            return String(format: "%.1fk", formatted)
        } else {
            return String(self)
        }
    }
}
