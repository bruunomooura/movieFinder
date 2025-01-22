//
//  String+Extensions.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import Foundation

extension String {
    // MARK: - Localized
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
    
    // MARK: - Format With Line Breaks
    /**
     Formats the string by inserting line breaks after a specified number of words.
     
     - Parameter wordCount: The number of words after which a line break (`\n`) is inserted.
     - Returns: A new string with line breaks added after the specified number of words.
     */
    public func formatWithLineBreaks(every wordCount: Int) -> String {
        let words = self.split(separator: " ")
        var formattedText: String = .init()
        
        for (index, word) in words.enumerated() {
            formattedText += word
            if (index + 1) % wordCount == 0
                && index != words.count - 1 {
                formattedText += "\n"
            } else if index != words.count - 1 {
                formattedText += " "
            }
        }
        return formattedText
    }
    
    /// Extracts the year from a date string using a specified format.
    ///
    /// This method takes a string representation of a date and extracts the year component based on the provided date format.
    /// If the string cannot be parsed into a valid date, it returns `"Data inválida"`.
    ///
    /// - Parameter format: A string representing the date format. The default format is `"MM/dd/yyyy"`. The format string
    ///   should follow the standard `DateFormatter` format (e.g., `"yyyy-MM-dd"`).
    /// - Returns: A `String` representing the year component of the date if valid, or `"Data inválida"` if the string
    ///   could not be parsed into a valid date.
    public func extractYear(fromFormat format: String = "MM/dd/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let data = dateFormatter.date(from: self) else { return "Data inválida" }
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: data)
        return String(year)
    }
}
