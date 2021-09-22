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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        layoutSubViews()
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
    }
    
    private func layoutSubViews() {
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

