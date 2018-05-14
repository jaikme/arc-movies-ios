//
//  MoviePresenter.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit


// MARK: - MoviePresenterInput

/// _MoviePresenterInput_ is a protocol for presenter input behaviours
protocol MoviePresenterInput: MovieInteractorOutput { }


// MARK: - MoviesPresenterOutput

/// _MoviePresenterOutput_ is a protocol for presenter output behaviours
protocol MoviePresenterOutput: class {
    
    /// Tells the output to display the movie
    ///
    /// - parameter viewModels: The movie view model
    func displayMovie(viewModel: MovieViewModel)
    
    /// Tells the output to dislpay an error
    ///
    /// - parameter viewModel: The error view model
    func displayError(viewModel: ErrorViewModel)
}


// MARK: - MoviesPresenter

/// _MoviePresenter_ is a class responsible for presenting movie logic
final class MoviePresenter {
    
    private(set) weak var output: MoviePresenterOutput?
    
    
    // MARK: - Initializers
    
    /// Initializes a new instance of _MoviePresenter_ with an output object
    ///
    /// - parameter output: The output that conforms to protocol _MoviePresenterOutput_
    ///
    /// - returns: The instance of _MoviePresenter_
    init(output: MoviePresenterOutput) {
        
        self.output = output
    }
}


// MARK: - MoviePresenterInput

extension MoviePresenter: MoviePresenterInput {
    
    /// Prepares a movie model for presentation and tells the output to display it
    ///
    /// - parameter movie: A movie objet
    func presentDetails(details: MovieDetails) {
        
        let viewModel = MovieViewModel(title: details.title, overview: details.overview, releaseDate: details.releaseDate, genres: details.genres, posterURL: details.posterURL)
        output?.displayMovie(viewModel: viewModel)
    }
    
    /// Prepares the error model for presentation and tells the output to display error
    ///
    /// - parameter error: The error
    func presentError(error: Error) {
        
        let errorViewModel = ErrorViewModel(title: Strings.Error.genericTitle, message: Strings.Error.genericMessage, buttonTitles: [Strings.Error.okButtonTitle])
        
        output?.displayError(viewModel: errorViewModel)
    }
}
