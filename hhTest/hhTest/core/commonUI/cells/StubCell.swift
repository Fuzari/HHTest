//
//  StubCell.swift
//  hhTest
//
//  Created by Андрей Яковлев on 03.10.2021.
//

import UIKit

final class StubCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
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
    
    // MARK: - Public methods
    func setup(text: String) {
        titleLabel.text = text
    }
    
    // MARK: - Private methods
    private func configureCell() {
        selectionStyle = .none
        layoutViews()
        applyTheme()
    }
    
    private func layoutViews() {
        contentView.addSubview(titleLabel)
        layoutTitleLabel()
    }
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
         titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 36),
         titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -36),
         titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36)].forEach({$0.isActive = true})
    }
    
    private func applyTheme() {
        backgroundColor = .clear
        contentView.backgroundColor = .mainBg
        titleLabel.textColor = .textMain
    }
}
