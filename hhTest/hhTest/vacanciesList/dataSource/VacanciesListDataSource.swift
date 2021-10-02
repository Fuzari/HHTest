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
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWith(type: VacancyCell.self, for: indexPath) else {
            fatalError("Unexpectable found nil during dequeue VacancyCell")
        }
        
        cell.setup(vacancy: vacancies[indexPath.row])
        return cell
    }
}

extension VacanciesListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == vacancies.count - 1 {
            fetchNextPageHandler?()
        }
    }
}
