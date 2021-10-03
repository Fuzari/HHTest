//
//  IDateFormatterService.swift
//  hhTest
//
//  Created by Андрей Яковлев on 03.10.2021.
//

import Foundation

protocol IDateFormatterService {
    var preferredLocale: Locale { get }
    var currentTimeZone: TimeZone { get }
    var localizedDateFormatter: DateFormatter { get }

    func hoursAndMinutesFrom(date: Date) -> String
    func shortDate(from date: Date) -> String
}
