//
//  NetworkManager.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import Foundation
import Combine

class NetworkManager {
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let session: URLSession
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    private func getBearerToken() -> String? {
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2RlZjQ1M2IwYjcxMmY2NDQ4NGRhMmNkMGI4MGY4YSIsInN1YiI6IjYyMjIwNWIwYzJmZjNkMDA0MzRhMjYzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.iEY--PU8qspBoXbJAK5HyKYhNC-zYjZh-6Ppl-1yexY"
    }
    
    private func configureAuthorizationHeader() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        if let token = getBearerToken() {
            configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        }
        return configuration
    }
    
    private lazy var configuredSession: URLSession = {
        let configuration = configureAuthorizationHeader()
        return URLSession(configuration: configuration)
    }()
    
    func performRequest<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
        let url = baseURL.appendingPathComponent(endpoint.path)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        
        if let parameters = endpoint.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return configuredSession.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
