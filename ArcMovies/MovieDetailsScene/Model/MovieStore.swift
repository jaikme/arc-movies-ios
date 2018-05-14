//
//  MovieStore.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation


// MARK: - MovieStore

/// _MovieStore_ is a class responsible for fetching movie details
final class MovieStore {

    fileprivate let networkClient: NetworkClientProtocol
    
    
    // MARK: - Initializers
    
    /// Initializes an instance of _MovieStore_ with an object that conforms to the protocol _NetworkClientProtocol_
    ///
    /// - parameter networkClient: The object to be used to send requests to the API
    ///
    /// - returns: The instance of _MovieStore_
    init(networkClient: NetworkClientProtocol = NetworkClient.sharedInstance) {
        
        self.networkClient = networkClient
    }
}


// MARK: - MovieStoreProtocol

extension MovieStore: MovieStoreProtocol {
    
    /// Fetches movie details
    ///
    /// - parameter movieId:    The movie identifier
    /// - parameter completion: The completion block
    func fetchDetails(movieId: Int, completion: @escaping (MovieDetails?, Error?) -> ()) {
        
        guard let url = MovieDBAPIEndpoint.getMovieDetails(movieId).url() else {
            
            completion(nil, MovieStoreError.invalidURL)
            
            return
        }
        
        let request = URLRequest.jsonRequest(url: url)
        
        networkClient.sendRequest(request: request) { data, response, error in
            
            var movieDetails: MovieDetails?
            var movieError: Error?
            
            if let json = data?.jsonDictionary() {

                movieDetails = MovieDetails.fromJSON(json: json)

            } else {
                
                movieError = MovieStoreError.invalidResponse
            }
            
            completion(movieDetails, movieError)
        }
    }
}
