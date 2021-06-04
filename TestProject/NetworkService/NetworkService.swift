//
//  NetworkService.swift
//  TestProject
//
//  Created by slava on 04/06/2021.
//

import Foundation
import Combine
import SwiftUI


protocol NetworkServiceProtocol {
    func getRequest(url: URL) ->  AnyPublisher<ModelApp, NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    func getRequest(url: URL) ->  AnyPublisher<ModelApp, NetworkError> {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return session
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap{
                guard let httpResponse = $0.response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.unknown
                }
                let value = try decoder.decode(ModelApp.self, from: $0.data)
                return ModelApp(data: value.data, view: value.view)
            }
            .mapError { err in
                if let error = err as? NetworkError {
                    return error
                } else {
                    return NetworkError.apiError(reason: err.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
