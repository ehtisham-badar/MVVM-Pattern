//
//  MovieEndPoint.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import Foundation
import Combine

struct MovieEndpoint: APIEndpoint {
    var path: String { "/discover/movie" }
    var method: String { "GET" }
    
    var parameters: [String: Any]? {
        return nil
    }
}
