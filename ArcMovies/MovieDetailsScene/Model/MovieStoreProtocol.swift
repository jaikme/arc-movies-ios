//
//  MovieStoreProtocol.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation


// MARK: - MovieStoreError

/// _MovieStoreError_ is an enumeration for movie store errors
///
/// - generic:         Generic error
/// - invalidURL:      Invalid URL error
/// - invalidResponse: Invalid response
enum MovieStoreError: Error {
    
    case generic
    case invalidURL
    case invalidResponse
}


// MARK: - MovieStoreProtocol

/// _MovieStoreProtocol_ is a protocol  for movie store behaviors
protocol MovieStoreProtocol {
    
    /// Fetches movie details from a store (API, memory, etc)
    ///
    /// - parameter movieId:    The movie identifier
    /// - parameter completion: The completion block
    func fetchDetails(movieId: Int, completion: @escaping (MovieDetails?, Error?) -> ())
}
