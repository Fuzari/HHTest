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

protocol IRequestExecutor {
    func execute<T: Decodable>(request: URLRequest, with type: T.Type, completion: @escaping ResponseCompletion<T>)
}

final class RequestExecutor: IRequestExecutor {
    
    private let urlSession: URLSession
    
    init(session: URLSession) {
        urlSession = session
    }
    
    func execute<T: Decodable>(request: URLRequest, with type: T.Type, completion: @escaping ResponseCompletion<T>) {
        urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard let response = response else {
                completion(.failure(NetworkError.clientError))
                return
            }
            
            guard let data = data else {
                return
            }
            
            self?.printLog(response: response, data: data)
            self?.handleResponse(data: data, type: type, completion: completion)
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
    
    private func printLog(response: URLResponse, data: Data) {
        print(response)
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            print("JSON Serialization failed")
            return
        }
        
        print(json)
    }
}
