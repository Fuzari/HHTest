//
//  MainViewController.swift
//  hhTest
//
//  Created by Андрей Яковлев on 04.10.2021.
//

import UIKit

final class MainViewController: UIViewController {
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let title = NSAttributedString(string: "Поиск вакансий", attributes: attributes)
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var router: IMainRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        applyTheme()
    }
    
    @objc private func searchButtonTapped() {
        router?.showVacanciesSearch()
    }
    
    private func layoutViews() {
        layoutSearchButton()
    }
    
    private func layoutSearchButton() {
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        [searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         searchButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
         searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
         searchButton.heightAnchor.constraint(equalToConstant: 48)].forEach({ $0.isActive = true })
    }
    
    private func applyTheme() {
        view.backgroundColor = .white
        searchButton.backgroundColor = .red
    }
}
