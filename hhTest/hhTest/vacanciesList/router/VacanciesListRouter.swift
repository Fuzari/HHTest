//
//  VacanciesListRouter.swift
//  hhTest
//
//  Created by Андрей Яковлев on 04.10.2021.
//

import UIKit

protocol IVacanciesListRouter {
    var context: UIViewController? { get }
    func dismiss(completion: EmptyClosure?)
}

final class VacanciesListRouter: IVacanciesListRouter {
    private(set) weak var context: UIViewController?
    
    init(context: UIViewController) {
        self.context = context
    }
    
    func dismiss(completion: EmptyClosure?) {
        context?.dismiss(animated: true, completion: completion)
    }
}
