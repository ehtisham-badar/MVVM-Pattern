//
//  DependencyContainer.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import Foundation

struct DependencyContainer {
    
    static func makeMovieViewModel() -> MovieViewModel {
        let networkManager = NetworkManager()
        return MovieViewModel(networkManager: networkManager)
    }
}
