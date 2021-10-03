//
//  DateFormatterService.swift
//  hhTest
//
//  Created by Андрей Яковлев on 03.10.2021.
//

import Foundation

final class DateFormatterService: IDateFormatterService {
    static let shared: IDateFormatterService = DateFormatterService()
    private init() { }
    
    let preferredLocale: Locale = Locale(identifier: "ru-RU")
    let currentTimeZone: TimeZone = TimeZone.autoupdatingCurrent
    var localizedDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = currentTimeZone
        formatter.locale = preferredLocale
        return formatter
    }
    
    // MARK: - Public methods
    func hoursAndMinutesFrom(date: Date) -> String {
        return hoursMinutesDateFormatter.string(from: date)
    }
    
    func shortDate(from date: Date) -> String {
        return shortDateDateFormatter.string(from: date)
    }
    
    // MARK: - Formatters
    private lazy var hoursMinutesDateFormatter: DateFormatter = {
        let formatter = localizedDateFormatter
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    private lazy var shortDateDateFormatter: DateFormatter = {
        let formatter = localizedDateFormatter
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
}
