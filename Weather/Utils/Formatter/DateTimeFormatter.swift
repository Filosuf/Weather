//
//  DateTimeFormatter.swift
//  Weather
//
//  Created by Filosuf on 23.01.2023.
//

import Foundation

enum DateFormat: String {
    case fullDate
    case date
    case time
}

final class DateTimeFormatter {

    let dateFormatter = DateFormatter()

    static let shared = DateTimeFormatter()

    // MARK: - Private Init
    private init() {}
    
    func dateToString(date: Date, format: DateFormat, timeZone: TimeZoneInfo?) -> String {
        switch format {
        case .fullDate:
            dateFormatter.dateFormat = "E dd/MM"
        case .date:
            dateFormatter.dateFormat = "dd/MM"
        case .time:
            dateFormatter.dateFormat = "HH:mm"
        }
        if let timeZoneName = timeZone?.name, let timeZone = TimeZone(identifier: timeZoneName) {
            dateFormatter.timeZone = timeZone
        } else if let offset = timeZone?.offset, let timeZone = TimeZone(secondsFromGMT: Int(offset)) {
            dateFormatter.timeZone = timeZone
        } else {
            dateFormatter.timeZone = .current
        }
        return dateFormatter.string(from: date)
    }
}
