//
//  DateFormatter+Formats.swift
//  ShareTheMealApp
//
//

import Foundation

extension DateFormatter {
    static let yMDDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
