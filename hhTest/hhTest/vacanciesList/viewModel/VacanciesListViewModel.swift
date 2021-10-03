//
//  VacanciesListViewModel.swift
//  hhTest
//
//  Created by Андрей Яковлев on 02.10.2021.
//

import Foundation

protocol VacanciesListViewModelInput: AnyObject {
    func fetchVacanciesWith(searchText: String?)
    func fetchNextVacancies()
}

protocol VacanciesListViewModelOutput: AnyObject {
    var vacanciesList: [IVacancyModel] { get }
    var successHandler: EmptyClosure? { get set }
    var onStartRequest: EmptyClosure? { get set }
    var errorHandler: ParameterClosure<NetworkError>? { get set }
}


protocol VacanciesListViewModelType: AnyObject {
    var input: VacanciesListViewModelInput { get }
    var output: VacanciesListViewModelOutput { get }
}

final class VacanciesListViewModel: VacanciesListViewModelType, VacanciesListViewModelInput, VacanciesListViewModelOutput {
    var input: VacanciesListViewModelInput { return self }
    var output: VacanciesListViewModelOutput { return self }
    
    private let networkLayer: IVacanciesListNetworkLayer
    
    private var searchText: String?
    private var pages: Int?
    private let itemsPerPage: Int = 10
    
    required init(networkLayer: IVacanciesListNetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    // MARK: - Output
    var vacanciesList: [IVacancyModel] = []
    var successHandler: EmptyClosure?
    var onStartRequest: EmptyClosure?
    var errorHandler: ParameterClosure<NetworkError>?
    
    // MARK: - Input
    func fetchVacanciesWith(searchText: String?) {
        guard searchText != self.searchText else {
            return
        }
        
        guard let text = searchText, text != "" else {
            vacanciesList.removeAll()
            self.searchText = nil
            pages = nil
            successHandler?()
            return
        }
        
        self.searchText = text
        guard text.count >= 3 else {
            return
        }
        
        onStartRequest?()
        vacanciesList.removeAll()
        pages = nil
        fetchNextVacancies()
    }
    
    func fetchNextVacancies() {
        let pageNumber = nextPageNumber
        networkLayer.fetchVacanciesList(searchText: searchText, perPage: itemsPerPage, pageNumber: pageNumber) { [weak self] result in
            switch result {
            case .success(let model):
                self?.handleResponse(model: model)
                self?.successHandler?()
            case .failure(let error):
                self?.errorHandler?(error)
            }
        }
    }
    
    // MARK: - Helpers
    private func handleResponse(model: IVacanciesResponseModel) {
        vacanciesList.append(contentsOf: model.items)
        if pages != nil {
            pages = model.pages
        }
    }
    
    var nextPageNumber: Int {
        let remainder = vacanciesList.count % itemsPerPage
        guard remainder != 0 else {
            return (vacanciesList.count / itemsPerPage) + 1
        }

        return ((vacanciesList.count + (itemsPerPage - remainder)) / itemsPerPage) + 1
    }
}
