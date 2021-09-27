//
//  URLComponents+QueryItems.swift
//  hhTest
//
//  Created by Андрей Яковлев on 28.09.2021.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(parameters: [String: String]) {
        queryItems = parameters.map({ URLQueryItem(name: $0.key, value: $0.value)})
    }
}
