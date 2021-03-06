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
    var dominantColor: UIColor?
    
    var movie: MoviesViewModel?
    
    @IBAction func closeTouchAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Initializers
    
    /// Initializes an instance of _MovieDetailsViewController_ with movie and configurator
    ///
    /// - parameter movie:       The movie
    /// - parameter configurator: The configurator
    ///
    /// - returns: The instance of _MovieDetailsViewController_
    init(movie: MoviesViewModel, configurator: MovieConfigurator = MovieConfigurator.sharedInstance) {
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}


// MARK: Configs

extension MovieDetailsViewController {
    
    private func configDetails() {
        setTitle()
    }
    
    private func setTitle() {
        self.title = ""
    }

}


// MARK: - Event handling

extension MovieDetailsViewController {
    
    /// Asks the output to fetch movie details
    func fetchDetails() {
        guard let movieId = movie?.id else { return }
        output.fetchDetails(movieId: movieId)
    }
}

// MARK: - MoviePresenterOutput

extension MovieDetailsViewController: MovieViewControllerInput, ErrorPresentable {
    func displayMovie(viewModel: MovieViewModel) {
        guard let tableDetails = self.tableView as? MovieDetailsTable else { return }
        tableDetails.movieDetails = viewModel
        tableDetails.configColors(with: dominantColor)
        configDetails()
        tableDetails.reloadData()
        tableDetails.refreshControl?.endRefreshing()
    }
    
    func displayError(viewModel: ErrorViewModel) {
        tableView.refreshControl?.endRefreshing()
        self.presentError(viewModel: viewModel)
    }
}
