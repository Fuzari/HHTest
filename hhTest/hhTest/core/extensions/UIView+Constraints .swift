//
//  UIView+Constraints .swift
//  hhTest
//
//  Created by Андрей Яковлев on 22.09.2021.
//

import UIKit

extension UIView {
    func fillToSuperview(with insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            [leftAnchor.constraint(
                equalTo: superview.leftAnchor,
                constant: insets.left),
            rightAnchor.constraint(
                equalTo: superview.rightAnchor,
                constant: -insets.right),
            topAnchor.constraint(
                equalTo: superview.topAnchor,
                constant: insets.top),
            bottomAnchor.constraint(
                equalTo: superview.bottomAnchor,
                constant: -insets.bottom)].forEach { $0.isActive = true }
        }
    }
}
