//
//  MoviesPresenter.swift
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

// MARK: - MoviesPresenterInput

/// _MoviesPresenterInput_ is a protocol for presenter input behaviours
protocol MoviesPresenterInput: MoviesInteractorOutput {}


// MARK: - MoviesPresenterOutput

/// _MoviesPresenterOutput_ is a protocol for presenter output behaviours
protocol MoviesPresenterOutput: class {
    
    /// Tells the output to display movies
    ///
    /// - parameter viewModels: The movie view models
    func displayMovies(viewModels: [MoviesViewModel])
    
    /// Tells the output to dislpay an error
    ///
    /// - parameter viewModel: The error view model
    func displayError(viewModel: ErrorViewModel)
}


// MARK: - MoviesPresenter

/// _MoviesPresenter_ is a class responsible for presenting movies logic
final class MoviesPresenter {
    
    private(set) weak var output: MoviesPresenterOutput?
    
    // MARK: - Initializers
    
    init(output: MoviesPresenterOutput) {
        
        self.output = output
    }
}


// MARK: - MoviesPresenterInput

extension MoviesPresenter: MoviesPresenterInput {
    
    /// Prepares the movie models for presentation and tells the output to display movies
    ///
    /// - parameter movies: The list of movies
    func presentMovies(movies: [Movie]) {
        
        let viewModels = movies.compactMap { movie -> MoviesViewModel in
            
            return MoviesViewModel(id: movie.id, title: movie.title, voteAverage: movie.voteAverage, posterURL: movie.posterURL)
        }
        
        output?.displayMovies(viewModels: viewModels)
    }
    
    /// Prepares the error model for presentation and tells the output to display error
    ///
    /// - parameter error: The error
    func presentError(error: Error) {
        
        let errorViewModel = ErrorViewModel(title: Strings.Error.genericTitle,
                                            message: Strings.Error.genericMessage,
                                            buttonTitles: [Strings.Error.okButtonTitle])
        
        output?.displayError(viewModel: errorViewModel)
    }
}

