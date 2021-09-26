//
//  VacancyResponse.swift
//  hhTest
//
//  Created by Андрей Яковлев on 26.09.2021.
//

import Foundation

struct SalaryModel: ISalaryModel, Decodable {
    var lowerBoundary: Int?
    var upperBoundary: Int?
    var currency: String?
    var gross: Bool?
    
    enum SalaryCodingKeys: String, CodingKey {
        case lowerBoundary = "from"
        case upperBoundary = "to"
        case currency
        case gross
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: SalaryCodingKeys.self)
        
        lowerBoundary = try? values.decode(Int.self, forKey: .lowerBoundary)
        upperBoundary = try? values.decode(Int.self, forKey: .upperBoundary)
        currency = try? values.decode(String.self, forKey: .currency)
        gross = try? values.decode(Bool.self, forKey: .gross)
    }
}

struct AreaModel: IAreaModel, Decodable {
    var id: String?
    var name: String?
}

struct EmployerModel: IEmployerModel, Decodable {
    var id: String?
    var name: String?
}

struct VacancyModel: IVacancyModel, Decodable {
    var id: String
    var name: String
    var salary: ISalaryModel
    var area: IAreaModel
    var publishedAt: Date
    var employer: IEmployerModel
    
    enum VacancyCodingKeys: String, CodingKey {
        case id
        case name
        case salary
        case area
        case publishedAt = "published_at"
        case employer
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: VacancyCodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        salary = try values.decode(SalaryModel.self, forKey: .salary)
        area = try values.decode(AreaModel.self, forKey: .area)
        publishedAt = try values.decode(Date.self, forKey: .publishedAt)
        employer = try values.decode(EmployerModel.self, forKey: .employer)
    }
}

struct VacanciesResponseModel: IVacanciesResponseModel, Decodable {
    var items: [IVacancyModel]
    var perPage: Int
    var pages: Int
    var found: Int
    
    enum VacanciesResponseKeys: String, CodingKey {
        case items
        case perPage = "per_page"
        case pages
        case found
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: VacanciesResponseKeys.self)
        
        items = try values.decode([VacancyModel].self, forKey: .items)
        perPage = try values.decode(Int.self, forKey: .perPage)
        pages = try values.decode(Int.self, forKey: .pages)
        found = try values.decode(Int.self, forKey: .found)
    }
}
