//
//  VacanciesListViewController.swift
//  hhTest
//
//  Created by Андрей Яковлев on 18.09.2021.
//

import UIKit

final class VacanciesListViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = responseModel else {
            return 0
        }
        
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWith(type: VacancyCell.self, for: indexPath) else {
            fatalError("Received unexpected nil value \(#file) \(#line)")
        }
        
        cell.setup(vacancy: responseModel!.items[indexPath.row])
        return cell
    }
    
    private let vacanciesSearchBar: UISearchBar = UISearchBar()
    private let vacanciesTableView: UITableView = UITableView()
    
    private let layer = VacanciesListNetworkLayer()
    private var responseModel: IVacanciesResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        layoutViews()
        
        layer.fetchVacanciesList { result in
            switch result {
            case .success(let model):
                self.responseModel = model
                DispatchQueue.main.async {
                    self.vacanciesTableView.reloadData()
                }
            case .failure( _ ):
                print("Error")
            }
        }
    }
    
    private func configureViews() {
        configureVacanciesSearchBar()
        configureVacanciesTableView()
        applyTheme()
    }
    
    private func configureVacanciesSearchBar() {
        vacanciesSearchBar.keyboardType = .default
        vacanciesSearchBar.autocapitalizationType = .sentences
        vacanciesSearchBar.autocorrectionType = .yes
        vacanciesSearchBar.barStyle = .black
    }
    
    private func configureVacanciesTableView() {
        vacanciesTableView.separatorStyle = .none
        vacanciesTableView.registerCellWith(type: VacancyCell.self)
        vacanciesTableView.dataSource = self
    }
    
    private func layoutViews() {
        layoutVacanciesSearchBar()
        layoutVacanciesTableView()
    }
    
    private func layoutVacanciesSearchBar() {
        navigationItem.titleView = vacanciesSearchBar
    }
    
    private func layoutVacanciesTableView() {
        view.addSubview(vacanciesTableView)
        vacanciesTableView.fillToSuperview()
    }
    
    private func applyTheme() {
        view.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .secBg
        navigationController?.navigationBar.isTranslucent = false
        vacanciesSearchBar.searchTextField.backgroundColor = .mainBg
        vacanciesSearchBar.tintColor = .textMain
        vacanciesSearchBar.searchTextField.textColor = .textMain
        vacanciesSearchBar.searchTextField.leftView?.tintColor = .textMain
        vacanciesTableView.backgroundColor = .mainBg
    }
}

