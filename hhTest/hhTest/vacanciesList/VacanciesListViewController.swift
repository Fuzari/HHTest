//
//  VacanciesListViewController.swift
//  hhTest
//
//  Created by Андрей Яковлев on 18.09.2021.
//

import UIKit

final class VacanciesListViewController: UIViewController {
    private let vacanciesSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.keyboardType = .default
        searchBar.autocapitalizationType = .sentences
        searchBar.autocorrectionType = .yes
        searchBar.barStyle = .black
        return searchBar
    }()
    
    private let exitButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.title = "Выход"
        return button
    }()
    
    private let vacanciesTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let viewModel: VacanciesListViewModelType
    private lazy var dataSource = VacanciesListDataSource()
    
    var router: IVacanciesListRouter?
    
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
    
    @objc private func exitButtonTapped() {
        router?.dismiss(completion: nil)
    }
    
    private func configureViews() {
        configureVacanciesSearchBar()
        configureExitButton()
        configureVacanciesTableView()
        applyTheme()
    }
    
    private func configureVacanciesSearchBar() {
        vacanciesSearchBar.delegate = self
    }
    
    private func configureExitButton() {
        exitButton.target = self
        exitButton.action = #selector(exitButtonTapped)
    }
    
    private func configureVacanciesTableView() {
        vacanciesTableView.dataSource = dataSource
        vacanciesTableView.delegate = dataSource
        vacanciesTableView.registerCellWith(type: VacancyCell.self)
        vacanciesTableView.registerCellWith(type: StubCell.self)
    }
    
    private func layoutViews() {
        layoutVacanciesSearchBar()
        layoutExitButton()
        layoutVacanciesTableView()
        layoutActivityIndicator()
    }
    
    private func layoutVacanciesSearchBar() {
        navigationItem.titleView = vacanciesSearchBar
    }
    
    private func layoutExitButton() {
        navigationItem.rightBarButtonItem = exitButton
    }
    
    private func layoutVacanciesTableView() {
        view.addSubview(vacanciesTableView)
        vacanciesTableView.fillToSuperview()
    }
    
    private func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.fillToSuperview()
    }
    
    private func applyTheme() {
        view.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .secBg
        navigationController?.navigationBar.isTranslucent = false
        vacanciesSearchBar.searchTextField.backgroundColor = .mainBg
        vacanciesSearchBar.tintColor = .textMain
        vacanciesSearchBar.searchTextField.textColor = .textMain
        vacanciesSearchBar.searchTextField.leftView?.tintColor = .textMain
        exitButton.tintColor = .textMain
        vacanciesTableView.backgroundColor = .mainBg
        activityIndicator.color = .textMain
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
                    self?.activityIndicator.stopAnimating()
                    self?.vacanciesTableView.reloadData()
                }
            }
        
        viewModel
            .output
            .onStartRequest = { [weak self] in
                self?.activityIndicator.startAnimating()
            }
        
        viewModel
            .output
            .errorHandler = { [weak self] (error) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.activityIndicator.stopAnimating()
                    AnnouncementView.showAnnouncement(context: self.view, title: "Упс!", message: error.description)
                }
            }
    }
}

// MARK: - UISearchBarDelegate
extension VacanciesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.input.fetchVacanciesWith(searchText: searchText)
        dataSource.isSearchMode = !searchText.isEmpty
    }
}
