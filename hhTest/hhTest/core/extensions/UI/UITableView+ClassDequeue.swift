//
//  UITableView+ClassDequeue.swift
//  hhTest
//
//  Created by Андрей Яковлев on 25.09.2021.
//

import UIKit

extension UITableView {
    func dequeueReusableCellWith<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T
    }
    
    func registerCellWith<T: UITableViewCell>(type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type))
    }
}
