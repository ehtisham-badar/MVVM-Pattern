//
//  APIEndpoints.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension APIEndpoint {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var headers: [String: String]? {
        return nil
    }
}
