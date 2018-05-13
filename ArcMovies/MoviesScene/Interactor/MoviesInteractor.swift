//
//  MoviesInteractor.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright (c) 2018 Jaime Costa Marques. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


// MARK: - MoviesInteractorInput

/// _MoviesInteractorInput_ is a protocol for interactor input behaviours
protocol MoviesInteractorInput: MoviesViewControllerOutput {}


// MARK: - MoviesInteractorOutput

/// _MoviesInteractorOutput_ is a protocol for interactor output behaviours
protocol MoviesInteractorOutput {
    
    /// Tells the output to present movies
    ///
    /// - parameter movies: The list of movies to present
    func presentMovies(movies: [Movie])
    
    /// Tells the output to present an error
    ///
    /// - parameter error: The error to present
    func presentError(error: Error)
}


// MARK: - MoviesInteractor

/// _MoviesInteractor_ is an interactor responsible for top movies business logic
final class MoviesInteractor {
    
    let output: MoviesInteractorOutput
    let worker: MoviesWorker
    
    var movies: [Movie]?
    
    
    // MARK: - Initializers
    
    /// Initializes an instance of _MoviesInteractor_ with an output and a worker
    ///
    /// - parameter output: The interactors output
    /// - parameter worker: The movies worker used to fetch movies
    ///
    /// - returns: An instance of _MoviesInteractor_
    init(output: MoviesInteractorOutput, worker: MoviesWorker = MoviesWorker()) {
        
        self.output = output
        self.worker = worker
    }
}

extension MoviesInteractor: MoviesInteractorInput {
    
    /// Fetches a list of upcoming movies through the worker
    func fetchMovies() {
        
        worker.fetchMovies { [weak self] movies, error in
            guard let `self` = self else { return }
            
            if let moviesError = error {
                
                self.output.presentError(error: moviesError)
                
            } else if let moviesArray = movies {
                
                self.movies = moviesArray
                self.output.presentMovies(movies: moviesArray)
            }
            
        }
    }
}
