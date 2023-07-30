//
//  MovieViewModel.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    private let networkManager: NetworkManager
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var movies: [Result] = []
    @Published var error: Error?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        $movies
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        $error
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func fetchMovies() {
        let endpoint = MovieEndpoint()
        networkManager.performRequest(endpoint: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("API request error: \(error)")
                }
            }, receiveValue: { [weak self] (movieModel: MovieModel) in
                self?.movies = movieModel.results
            })
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
