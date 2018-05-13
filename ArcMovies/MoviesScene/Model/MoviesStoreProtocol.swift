//
//  MoviesStoreError.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

// MARK: - MoviesStoreError

/// _MoviesStoreError_ is an enumeration for movie store errors
///
/// - generic:         Generic error
/// - invalidURL:      Invalid URL error
/// - invalidResponse: Invalid response
enum MoviesStoreError: Error {
    
    case generic
    case invalidURL
    case invalidResponse
}

// MARK: - MoviesStoreProtocol

/// _MoviesStoreProtocol_ is a protocol  for movie store behaviors
protocol MoviesStoreProtocol {
    
    /// Fetches movies from a store (API, memory, etc)
    ///
    /// - parameter completion: The completion block
    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> ())
}
