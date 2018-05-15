//
//  MovieWorker.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

// MARK: - MovieWorker.swift

/// _MovieWorker.swift_ is a worker object responsible to fetch details from a store
class MovieWorker {
    
    fileprivate var store: MovieStoreProtocol
    
    
    // MARK: - Initializers
    
    /// Initializes an _MovieWorker_ with a store
    ///
    /// - parameter store: A store where to fetch movie details from (API, memory, etc)
    ///
    /// - returns: The instance of _MovieWorker_
    init(store: MovieStoreProtocol = MovieStore()) {
        
        self.store = store
    }
    
    
    // MARK: - Business Logic
    
    /// Fetches movie details from a store
    ///
    /// - parameter movieId:   The movie identifier
    /// - parameter completion: The completion block
    func fetchDetails(movieId: Int, completion: @escaping (MovieDetails?, Error?) -> ()) {
        
        store.fetchDetails(movieId: movieId, completion: completion)
    }
}
