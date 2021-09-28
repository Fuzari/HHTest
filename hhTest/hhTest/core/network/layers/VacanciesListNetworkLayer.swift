//
//  VacanciesListNetworkLayer.swift
//  hhTest
//
//  Created by Андрей Яковлев on 28.09.2021.
//

import Foundation

typealias VacanciesResponseResult = Result<VacanciesResponseModel, NetworkError>
typealias VacanciesResponseCompletion = ParameterClosure<VacanciesResponseResult>

protocol IVacanciesListNetworkLayer {
    func fetchVacanciesList(completion: @escaping VacanciesResponseCompletion)
}

final class VacanciesListNetworkLayer: IVacanciesListNetworkLayer {
    
    let executor = RequestExecutor()
    
    func fetchVacanciesList(completion: @escaping VacanciesResponseCompletion) {
        var urlComponents = URLComponents()
        urlComponents.scheme = HHApiScheme.https.rawValue
        urlComponents.host = HHApiHost.main.rawValue
        urlComponents.path = "/\(HHApiResources.vacancies.rawValue)"
        let parameters: [String : String] = ["text": "iOS", "per_page": "2"]
        urlComponents.setQueryItems(parameters: parameters)
        
        guard let url = urlComponents.url else {
            completion(.failure(.clientError))
            return
        }
        
        let request = URLRequest(url: url)
        executor.execute(request: request, with: VacanciesResponseModel.self) { result in
            switch result {
            case .success(let responseModel):
                completion(.success(responseModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
