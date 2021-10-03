//
//  VacancyModel.swift
//  hhTest
//
//  Created by Андрей Яковлев on 26.09.2021.
//

import Foundation

protocol ISalaryModel {
    var lowerBoundary: Int? { get }
    var upperBoundary: Int? { get }
    var currency: String? { get }
    var gross: Bool? { get }
}

protocol IAreaModel {
    var id: String? { get }
    var name: String? { get }
}

protocol IEmployerModel {
    var id: String? { get }
    var name: String? { get }
}

protocol IVacancyModel {
    var id: String { get }
    var name: String { get }
    var salary: ISalaryModel { get }
    var area: IAreaModel { get }
    var publishedAt: Date { get }
    var employer: IEmployerModel { get }
}

protocol IVacanciesResponseModel {
    var items: [IVacancyModel] { get }
    var pages: Int { get }
}
