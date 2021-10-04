//
//  MainRouter.swift
//  hhTest
//
//  Created by Андрей Яковлев on 04.10.2021.
//

import UIKit

protocol IMainRouter {
    var context: UIViewController? { get }
    func showVacanciesSearch()
}

final class MainRouter: IMainRouter {
    private(set) weak var context: UIViewController?
    
    init(context: UIViewController) {
        self.context = context
    }
    
    func showVacanciesSearch() {
        let executor = RequestExecutor(session: URLSession(configuration: .default))
        let layer = VacanciesListNetworkLayer(executor: executor)
        let vm = VacanciesListViewModel(networkLayer: layer)
        let controller = VacanciesListViewController(viewModel: vm)
        let router = VacanciesListRouter(context: controller)
        controller.router = router
        let nc = UINavigationController(rootViewController: controller)
        nc.modalTransitionStyle = .coverVertical
        nc.modalPresentationStyle = .overFullScreen
        context?.present(nc, animated: true, completion: nil)
    }
}
