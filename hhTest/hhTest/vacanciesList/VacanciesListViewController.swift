//
//  VacanciesListViewController.swift
//  hhTest
//
//  Created by Андрей Яковлев on 18.09.2021.
//

import UIKit

final class VacanciesListViewController: UIViewController {
    private let vacanciesTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        layoutSubViews()
    }
    
    private func configureViews() {
        configureVacanciesTableView()
        applyTheme()
    }
    
    private func configureVacanciesTableView() {
        vacanciesTableView.separatorStyle = .none
    }
    
    private func layoutSubViews() {
        layoutVacanciesTableView()
    }
    
    private func layoutVacanciesTableView() {
        view.addSubview(vacanciesTableView)
        vacanciesTableView.fillToSuperview()
    }
    
    private func applyTheme() {
        view.backgroundColor = .clear
        vacanciesTableView.backgroundColor = .mainBg
    }
}

