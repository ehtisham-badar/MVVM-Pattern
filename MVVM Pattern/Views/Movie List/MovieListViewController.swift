//
//  MovieListViewController.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MovieViewModel!
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        fetchMovies()
    }
    
    private func setupViewModel() {
        let networkManager = NetworkManager()
        viewModel = MovieViewModel(networkManager: networkManager)
        
        viewModel.$movies
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.updateSnapshot()
                }
                
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$error
            .sink { error in
                print(error?.localizedDescription ?? "")
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        tableView.dataSource = dataSource
    }
    
    private func fetchMovies() {
        viewModel.fetchMovies()
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Int, Result> {
        let reuseIdentifier = "MovieListTableViewCell"
        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, movie in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MovieListTableViewCell else {
                fatalError("Failed to dequeue \(MovieListTableViewCell.self) with reuseIdentifier: \(reuseIdentifier)")
            }
            cell.lblTitle.text = movie.title
            // Set other properties of the cell based on the 'movie' object if needed.
            return cell
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Result>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.movies)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
