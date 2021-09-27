//
//  NetworkError.swift
//  hhTest
//
//  Created by Андрей Яковлев on 28.09.2021.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case clientError
    case mappingError
    
    var description: String {
        switch self {
        case .serverError:
            return "Что-то случилось на сервере"
        case .mappingError:
            return "Ошибка получения информации из ответа"
        case .clientError:
            return "Неправильный запрос"
        }
    }
}
