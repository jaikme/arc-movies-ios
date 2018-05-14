//
//  MovieDetailsViewController.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit


// MARK: - MovieViewControllerInput

/// _MovieViewControllerInput_ is a protocol for view controller input behaviours
protocol MovieViewControllerInput: MoviePresenterOutput {}


// MARK: - MovieViewControllerOutput

/// _MovieViewControllerInput_ is a protocol for view controller output behaviours
protocol MovieViewControllerOutput {
    
    var movieDetails: MovieDetails? { get }
    
    
    /// Tells the output (interactor) to fetch movie details
    ///
    /// - parameter movieId: The movie identifier
    func fetchDetails(movieId: Int)
}


// MARK: - MovieDetailsViewController

/// _MovieDetailsViewController_ is a view controller responsible for displaying movie details
final class MovieDetailsViewController: UITableViewController {
    
    var output: MovieViewControllerOutput!
    var router: MovieRouterProtocol!

    var movie: Movie?
    
    // MARK: - Initializers
    
    /// Initializes an instance of _ArtistViewController_ with artist and configurator
    ///
    /// - parameter artist:       The artist
    /// - parameter configurator: The configurator
    ///
    /// - returns: The instance of _ArtistViewController_
    init(movie: Movie, configurator: MovieConfigurator = MovieConfigurator.sharedInstance) {
        
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
        
        configure(configurator: configurator)
    }
    
    /// Initializes an instance of _MovieDetailsViewController_ from storyboard
    ///
    /// - parameter coder: The coder
    ///
    /// - returns: The instance of _MovieDetailsViewController_
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure(configurator: MovieConfigurator.sharedInstance)
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: MovieConfigurator = MovieConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
}

// MARK: Lifecycle

extension MovieDetailsViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetails()
    }
}


// MARK: Configs

//extension MoviesViewController {}


// MARK: - Event handling

extension MovieDetailsViewController {
    
    /// Asks the output to fetch movie details
    func fetchDetails() {
        guard let movieId = movie?.id else { return }
        output.fetchDetails(movieId: movieId)
    }
}

// MARK: - ArtistPresenterOutput

extension MovieDetailsViewController: MovieViewControllerInput, ErrorPresentable {
    func displayMovie(viewModel: MovieViewModel) {
        guard let tableDetails = self.tableView as? MovieDetailsTable else { return }
        tableDetails.movieDetails = viewModel
        tableDetails.reloadData()
        tableDetails.refreshControl?.endRefreshing()
    }
    
    func displayError(viewModel: ErrorViewModel) {
        
        tableView.refreshControl?.endRefreshing()
        self.presentError(viewModel: viewModel)
    }
}
