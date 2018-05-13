//
//  Configurator.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

struct MovieDBAPI {
    
    static let baseUrl: BaseURLType = .production
    static let imageUrl: BaseURLType = .imageProduction
    static let apiKey = "060fe300cc5a08ba0515ed2dd96af98f"
}

public enum BaseURLType : String {
    case production = "https://api.themoviedb.org/3/"
    case imageProduction = "https://image.tmdb.org/t/p/w400"
}

// MARK: - MovieDBAPIEndpoint

/// _MovieDBAPIEndpoint_ is an enumeration of all Last FM types of API requests
///
/// - getUpcomingMovies: The get upcoming movies request
enum MovieDBAPIEndpoint {
    
    case getUpcomingMovies(Int)
    case getMovieDetails(Int)
}


// MARK: - URLConvertible

extension MovieDBAPIEndpoint: URLConvertible {
    // TODO: Remove api_key redundance
    func url() -> URL? {
        switch self {
        case .getUpcomingMovies(let page):
            let endpoint = "movie/upcoming"
            return URL(string: "\(MovieDBAPI.baseUrl.rawValue)\(endpoint)?api_key=\(MovieDBAPI.apiKey)&page=\(page)")
        case .getMovieDetails(let movieId):
            let endpoint = "movie/\(movieId)"
            return URL(string: "\(MovieDBAPI.baseUrl.rawValue)\(endpoint)?api_key=\(MovieDBAPI.apiKey)")
        }
    }
}
