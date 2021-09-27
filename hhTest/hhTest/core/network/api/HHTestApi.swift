//
//  HHTestApi.swift
//  hhTest
//
//  Created by Андрей Яковлев on 28.09.2021.
//

import Foundation

enum HHApiScheme: String {
    case https
}

enum HHApiHost: String {
    case main = "api.hh.ru"
}

enum HHApiResources: String {
    case vacancies
}
