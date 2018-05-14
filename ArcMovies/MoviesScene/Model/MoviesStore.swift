//
//  MoviesStore.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation


// MARK: - MoviesStore

/// _MoviesStore_ is a class responsible for fetching movies
final class MoviesStore {
    
    private struct Constants {
        static let moviesDictionaryKey = "results"
    }
    
    static var moviesPage = 1
    private let networkClient: NetworkClientProtocol
    
    
    // MARK: - Initializers
    
    /// Initializes an instance of _MoviesStore_ with an object that conforms to the protocol _NetworkClientProtocol_
    ///
    /// - parameter networkClient: The object to be used to send requests to the API
    ///
    /// - returns: The instance of _MoviesStore_
    init(networkClient: NetworkClientProtocol = NetworkClient.sharedInstance) {
        
        self.networkClient = networkClient
    }
}


// MARK: - MoviesStoreProtocol

extension MoviesStore: MoviesStoreProtocol {
    
    /// Fetches a list of top movies
    ///
    /// - parameter completion: The completion block
    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        
        let page = MoviesStore.moviesPage
        guard let url = MovieDBAPIEndpoint.getUpcomingMovies(page).url() else {
            
            completion([], MoviesStoreError.invalidURL)
            
            return
        }
        
        let request = URLRequest.jsonRequest(url: url)
        
        networkClient.sendRequest(request: request) { data, response, error in
            
            var movies: [Movie]?
            var moviesError: Error?
            
            if let json = data?.jsonDictionary() {
                
                if let moviesArray = json[Constants.moviesDictionaryKey] as? [[String: Any]] {
                    
                    movies = moviesArray.compactMap { dictionary -> Movie? in
                        
                        return Movie.fromJSON(json: dictionary)
                    }
                    
                } else {
                    
                    moviesError = MoviesStoreError.invalidResponse
                }
                
            } else {
                
                moviesError = MoviesStoreError.invalidResponse
            }
            
            completion(movies, moviesError)
        }
    }
}
