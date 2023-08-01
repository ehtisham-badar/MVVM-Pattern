//
//  MovieModel.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable, Hashable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    // Implement equality check for Result
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.adult == rhs.adult &&
        lhs.backdropPath == rhs.backdropPath &&
        lhs.genreIDS == rhs.genreIDS &&
        lhs.id == rhs.id &&
        lhs.originalLanguage == rhs.originalLanguage &&
        lhs.originalTitle == rhs.originalTitle &&
        lhs.overview == rhs.overview &&
        lhs.popularity == rhs.popularity &&
        lhs.posterPath == rhs.posterPath &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.title == rhs.title &&
        lhs.video == rhs.video &&
        lhs.voteAverage == rhs.voteAverage &&
        lhs.voteCount == rhs.voteCount
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case pl = "pl"
    case uk = "uk"
    case es = "es"
}

extension MovieModel {
    static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.page == rhs.page &&
        lhs.results == rhs.results &&
        lhs.totalPages == rhs.totalPages &&
        lhs.totalResults == rhs.totalResults
    }
}
