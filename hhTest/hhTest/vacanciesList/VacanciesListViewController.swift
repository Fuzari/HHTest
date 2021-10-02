//
//  VacanciesListViewController.swift
//  hhTest
//
//  Created by Андрей Яковлев on 18.09.2021.
//

import UIKit

final class VacanciesListViewController: UIViewController {
    private let vacanciesSearchBar: UISearchBar = UISearchBar()
    private let vacanciesTableView: UITableView = UITableView()
    
    private let viewModel: VacanciesListViewModelType
    private lazy var dataSource = VacanciesListDataSource()
    
    init(viewModel: VacanciesListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        layoutViews()
        bindViewModel()
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
        vacanciesSearchBar.delegate = self
    }
    
    private func configureVacanciesTableView() {
        vacanciesTableView.separatorStyle = .none
        vacanciesTableView.registerCellWith(type: VacancyCell.self)
        vacanciesTableView.dataSource = dataSource
        vacanciesTableView.delegate = dataSource
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
    
    // MARK: - Bindings
    private func bindViewModel() {
        bindInput()
        bindOutput()
    }
    
    private func bindInput() {
        dataSource.fetchNextPageHandler = { [weak self] in
            self?.viewModel.input.fetchNextVacancies()
        }
    }
    
    private func bindOutput() {
        viewModel
            .output
            .successHandler = { [weak self] in
                guard let self = self else { return }
                self.dataSource.vacancies = self.viewModel.output.vacanciesList
                DispatchQueue.main.async { [weak self] in
                    self?.vacanciesTableView.reloadData()
                }
            }
    }
}

// MARK: - UISearchBarDelegate
extension VacanciesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.input.fetchVacanciesWith(searchText: searchText)
    }
}
