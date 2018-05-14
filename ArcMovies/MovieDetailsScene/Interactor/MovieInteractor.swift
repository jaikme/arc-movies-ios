//
//  MovieInteractor.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit


// MARK: - MovieInteractorInput

/// _MovieInteractorInput_ is a protocol for interactor input behaviours
protocol MovieInteractorInput: MovieViewControllerOutput {}


// MARK: - MovieInteractorOutput

/// _MovieInteractorOutput_ is a protocol for interactor output behaviours
protocol MovieInteractorOutput {
    
    /// Tells the output to present movie details
    ///
    /// - parameter details: The movie details to present
    func presentDetails(details: MovieDetails)
    
    /// Tells the output to present an error
    ///
    /// - parameter error: The error to present
    func presentError(error: Error)
}


// MARK: - MovieInteractor

/// _MovieInteractor_ is an interactor responsible for movie details business logic
final class MovieInteractor: MovieInteractorInput {
    
    var movieDetails: MovieDetails?

    let output: MovieInteractorOutput
    let worker: MovieWorker

    
    // MARK: - Initializers
    
    /// Initializes an instance of _MovieInteractor_ with an output and a worker
    ///
    /// - parameter output: The interactors output
    /// - parameter worker: The movie worker used to fetch movie details
    ///
    /// - returns: An instance of _MovieInteractor_
    init(output: MovieInteractorOutput, worker: MovieWorker = MovieWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    
    // MARK: - Business logic
    
    /// Fetches movie details through the worker
    ///
    /// - parameter movieId: The movie identifier
    func fetchDetails(movieId: Int) {
        
        worker.fetchDetails(movieId: movieId) { [weak self] movieDetails, error in
            guard let `self` = self else { return }

                if let movieError = error {
                    
                    self.output.presentError(error: movieError)
                    
                } else if let movieDetails = movieDetails {
                    
                    self.movieDetails = movieDetails
                    self.output.presentDetails(details: movieDetails)
                }
            
        }
    }
}
