//
//  MovieWorkerTest.swift
//  ArcMoviesTests
//
//  Created by Jaime Costa Marques on 14/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import XCTest
@testable import ArcMovies

// MARK: - MoviesWorkerTests

final class MovieWorkerTests: XCTestCase {
    
    
    // MARK: - Tests
    
    func testFetchMovieDetailsShouldFetchMoviesFromStore() {
        
        // Given
        
        let store = MovieStoreSpy()
        let worker = MovieWorker(store: store)
        
        // When
        
        worker.fetchDetails(movieId: 0) { (details, error) in
        }
        
        // Then
        
        XCTAssertTrue(store.fetchMovieCalled)
    }
}


// MARK: - MoviesStoreSpy

final class MovieStoreSpy: MovieStoreProtocol {

    var fetchMovieCalled = false
    
    func fetchDetails(movieId: Int, completion: @escaping (MovieDetails?, Error?) -> ()) {
        
        fetchMovieCalled = true
        
        completion(nil, nil)
    }
}
