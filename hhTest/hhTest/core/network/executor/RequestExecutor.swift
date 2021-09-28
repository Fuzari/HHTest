//
//  RequestExecutor.swift
//  hhTest
//
//  Created by Андрей Яковлев on 28.09.2021.
//

import Foundation

typealias EmptyClosure = () -> Void
typealias ParameterClosure<T> = (T) -> Void
typealias ResponseCompletion<T> = (Result<T, NetworkError>) -> Void

struct RequestExecutor {
    private let urlSession = URLSession(configuration: .default)
    
    func execute<T: Decodable>(request: URLRequest, with type: T.Type, completion: @escaping ResponseCompletion<T>){
        urlSession.dataTask(with: request) { data, response, error in
            print(response)
            guard let data = data else {
                return
            }
            
            handleResponse(data: data, type: type, completion: completion)
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(data: Data, type: T.Type, completion: @escaping ResponseCompletion<T>) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let object = try? decoder.decode(T.self, from: data) else {
            completion(.failure(.mappingError))
            return
        }
        
        completion(.success(object))
    }
}
