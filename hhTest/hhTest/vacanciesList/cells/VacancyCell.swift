//
//  VacancyCell.swift
//  hhTest
//
//  Created by Андрей Яковлев on 25.09.2021.
//

import UIKit

final class VacancyCell: UITableViewCell {
    // MARK: - UI
    private let holderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22.0)
        return label
    }()
    
    private let salaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    private let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    private let publishmentDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        [vacancyNameLabel, salaryLabel, areaLabel, publishmentDateLabel, companyNameLabel].forEach( {$0.text = nil} )
    }
    
    // MARK: - Public methods
    func setup(vacancy: IVacancyModel) {
        vacancyNameLabel.text = vacancy.name
        salaryLabel.text = salaryInfo(salaryModel: vacancy.salary)
        areaLabel.text = vacancy.area.name
        publishmentDateLabel.text = dateInfo(date: vacancy.publishedAt)
        companyNameLabel.text = vacancy.employer.name
    }
    
    // MARK: - Private methods
    private func salaryInfo(salaryModel: ISalaryModel?) -> String {
        guard let salary = salaryModel else {
            return "Заработная плата не указана"
        }
        
        var resultText: String = ""
        if let from = salary.lowerBoundary, let to = salary.upperBoundary {
            resultText = "От \(from) до \(to) \(salary.currency ?? "")"
        }
        if let to = salary.upperBoundary {
            resultText = "До \(to) \(salary.currency ?? "")"
        }
        if let from = salary.lowerBoundary {
            resultText = "От \(from) \(salary.currency ?? "")"
        }
       
        guard let gross = salary.gross else {
            return resultText
        }
        
        let grossText = gross ? "gross" : "net"
        resultText += " \(grossText)"
        return resultText
    }
    
    private func dateInfo(date: Date) -> String {
        let timeText = DateFormatterService.shared.hoursAndMinutesFrom(date: date)
        let dateText = DateFormatterService.shared.shortDate(from: date)
        return "\(timeText), \(dateText)"
    }
    
    private func configureCell() {
        selectionStyle = .none
        layoutViews()
        applyTheme()
    }
    
    private func layoutViews() {
        contentView.addSubview(holderView)
        holderView.addSubview(vacancyNameLabel)
        holderView.addSubview(salaryLabel)
        holderView.addSubview(areaLabel)
        holderView.addSubview(companyNameLabel)
        holderView.addSubview(publishmentDateLabel)
        
        holderView.fillToSuperview(with: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        layoutVacancyLabel()
        layoutSalaryLabel()
        layoutAreaLabel()
        layoutCompanyNameLabel()
        layoutPublishmentDateLabel()
    }
    
    private func layoutVacancyLabel() {
        vacancyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        [vacancyNameLabel.topAnchor.constraint(equalTo: holderView.topAnchor,
                                               constant: 12),
         vacancyNameLabel.leftAnchor.constraint(equalTo: holderView.leftAnchor,
                                                constant: 16),
         vacancyNameLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor,
                                                 constant: -16)].forEach({$0.isActive = true})
    }
    
    private func layoutSalaryLabel() {
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        [salaryLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor,
                                               constant: 5),
         salaryLabel.leftAnchor.constraint(equalTo: holderView.leftAnchor,
                                                constant: 16),
         salaryLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor,
                                                 constant: -16)].forEach({$0.isActive = true})
    }
    
    private func layoutAreaLabel() {
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        [areaLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor,
                                               constant: 5),
         areaLabel.leftAnchor.constraint(equalTo: holderView.leftAnchor,
                                                constant: 16),
         areaLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor,
                                                 constant: -16)].forEach({$0.isActive = true})
    }
    
    private func layoutCompanyNameLabel() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        [companyNameLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor,
                                               constant: 5),
         companyNameLabel.leftAnchor.constraint(equalTo: holderView.leftAnchor,
                                                constant: 16),
         companyNameLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor,
                                                 constant: -16)].forEach({$0.isActive = true})
    }
    
    private func layoutPublishmentDateLabel() {
        publishmentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        [publishmentDateLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor,
                                               constant: 5),
         publishmentDateLabel.leftAnchor.constraint(greaterThanOrEqualTo: holderView.leftAnchor, constant: 16),
         publishmentDateLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor,
                                                 constant: -16),
         publishmentDateLabel.bottomAnchor.constraint(equalTo: holderView.bottomAnchor,
                                                      constant: -12)].forEach({$0.isActive = true})
    }
    
    private func applyTheme() {
        backgroundColor = .clear
        holderView.backgroundColor = .secBg
        [vacancyNameLabel, salaryLabel, areaLabel, publishmentDateLabel, companyNameLabel].forEach( {$0.textColor = .textMain} )
    }
}
