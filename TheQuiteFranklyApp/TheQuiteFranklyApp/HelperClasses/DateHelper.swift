//
//  DateHelper.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 09/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

private enum FallbackTimeFormat {
    static let tweleveHourFormat = "en_US_POSIX"
}

private enum DefaultTimeFormats {
    static let backendTimeformat = "yyyy-MM-dd HH:mm:ss"
}

struct DateHelper {
    private static let dateFormatter = DateFormatter()
    
    static func dateString(date: Date, returnFormat: String, locale: Locale = Calendar.current.locale!, timeZone: TimeZone = Calendar.current.timeZone) -> String {
        dateFormatter.dateFormat = returnFormat
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: date)
    }
    
    static func dateFromString(dateString: String, expectedFormat: String = DefaultTimeFormats.backendTimeformat) -> Date? {
        dateFormatter.dateFormat = expectedFormat
        return dateFormatter.date(from: dateString)
    }
}
