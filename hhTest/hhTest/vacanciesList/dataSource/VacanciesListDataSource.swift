//
//  VacanciesListDataSource.swift
//  hhTest
//
//  Created by Андрей Яковлев on 03.10.2021.
//

import UIKit

final class VacanciesListDataSource: NSObject, UITableViewDataSource {
    var vacancies: [IVacancyModel] = []
    var fetchNextPageHandler: EmptyClosure?
    var isSearchMode: Bool = false
    
    private var cellsCount: Int {
        guard isSearchMode else {
            return 1
        }
        
        return vacancies.isEmpty ? 1 : vacancies.count
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearchMode {
            if vacancies.isEmpty {
                guard let cell = tableView.dequeueReusableCellWith(type: StubCell.self, for: indexPath) else {
                    fatalError("Unexpectable found nil during dequeue StubCell")
                }
                
                cell.setup(text: "По этому запросу ничего не найдено")
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCellWith(type: VacancyCell.self, for: indexPath) else {
                    fatalError("Unexpectable found nil during dequeue VacancyCell")
                }
                
                cell.setup(vacancy: vacancies[indexPath.row])
                return cell
            }
        } else {
            guard let cell = tableView.dequeueReusableCellWith(type: StubCell.self, for: indexPath) else {
                fatalError("Unexpectable found nil during dequeue StubCell")
            }
            
            cell.setup(text: "Набери текст, чтобы увидеть результат")
            return cell
        }
    }
}

extension VacanciesListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isSearchMode && indexPath.row == vacancies.count - 1 {
            fetchNextPageHandler?()
        }
    }
}
