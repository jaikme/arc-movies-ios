//
//  MoviesWorkerTests.swift
//  ArcMoviesTests
//
//  Created by Jaime Costa Marques on 14/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import XCTest
@testable import ArcMovies

// MARK: - MoviesWorkerTests

final class MoviesWorkerTests: XCTestCase {
    
    
    // MARK: - Tests
    
    func testFetchMoviesShouldFetchMoviesFromStore() {
        
        // Given
        
        let store = MoviesStoreSpy()
        let worker = MoviesWorker(store: store)
        
        // When
        
        worker.fetchMovies { movies, error in
        }
        
        // Then
        
        XCTAssertTrue(store.fetchMoviesCalled)
    }
}


// MARK: - MoviesStoreSpy

final class MoviesStoreSpy: MoviesStoreProtocol {
    
    var fetchMoviesCalled = false
    
    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        
        fetchMoviesCalled = true
        
        completion(nil, nil)
    }
}
