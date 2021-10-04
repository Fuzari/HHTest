//
//  AnnouncementView.swift
//  hhTest
//
//  Created by Андрей Яковлев on 03.10.2021.
//

import UIKit

final class AnnouncementView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func showAnnouncement(context: UIView, title: String, message: String) {
        createAndShowAnnouncment(context, title: title, message: message)
    }
    
    private static func createAndShowAnnouncment(_ context: UIView, title: String, message: String) {
        let isOnScreen = context.subviews.contains(where: { $0 is AnnouncementView })
        guard isOnScreen == false else {
            return
        }

        let frame = CGRect(x: Constants.horizontalMargin,
                           y: context.frame.height,
                           width: context.frame.width - 2 * Constants.horizontalMargin,
                           height: 102)
        let announce = AnnouncementView(frame: frame)
        announce.setup(title: title, message: message)
        context.addSubview(announce)
        announce.showAnimated(completion: { [weak announce] in
            announce?.hideAnimated()
        })
    }
    
    private func showAnimated(completion: @escaping (() -> Void)) {
        guard let superview = superview else {
            return
        }

        let destY = superview.bounds.height
            - bounds.height / 2
            - Constants.bottomMargin

        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.center = CGPoint(x: superview.bounds.width / 2, y: ceil(destY))
        }, completion: { _ in
            completion()
        })
    }

    private func hideAnimated() {
        guard let superview = superview else {
            return
        }

        let destY = superview.bounds.size.height + bounds.height / 2

        UIView.animate(withDuration: Constants.animationDuration, delay: Constants.timeOnTheScreen, animations: {
            self.center = CGPoint(x: superview.bounds.width / 2, y: ceil(destY))
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    private func setup(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    
    private func configureView() {
        layer.cornerRadius = Constants.cornerRadiusOfView
        layer.borderWidth = Constants.borderWidth
        layoutViews()
        applyTheme()
    }
    
    private func layoutViews() {
        addSubview(titleLabel)
        addSubview(messageLabel)
        layoutTitleLabel()
        layoutMessageLabel()
    }
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
         titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
         titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)].forEach({$0.isActive = true})
    }
    
    private func layoutMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        [messageLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 12),
         messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
         messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
         messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)].forEach({$0.isActive = true})
    }
    
    private func applyTheme() {
        backgroundColor = .secBg
        layer.borderColor = UIColor.textMain.cgColor
        [titleLabel, messageLabel].forEach( {$0.textColor = .textMain} )
    }
}


private extension AnnouncementView {
    struct Constants {
        static let cornerRadiusOfView: CGFloat = 10
        static let borderWidth: CGFloat = 1
        static let timeOnTheScreen: Double = 4
        static let animationDuration: Double = 0.3
        static let bottomMargin: CGFloat = 24
        static let horizontalMargin: CGFloat = 24
    }
}
