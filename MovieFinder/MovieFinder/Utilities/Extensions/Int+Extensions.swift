//
//  Int+Extensions.swift
//  MovieFinder
//
//  Created by Bruno Moura on 19/01/25.
//

extension Int {
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
