//
//  HomeViewController.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 10/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

// MARK: - MoviesViewControllerInput

/// _MoviesViewControllerInput_ is a protocol for view controller input behaviours
protocol MoviesViewControllerInput: MoviesPresenterOutput {}

// MARK: - MoviesViewControllerOutput

/// _MoviesViewControllerInput_ is a protocol for view controller output behaviours
protocol MoviesViewControllerOutput {
    
    var movies: [Movie]? { get }
    
    /// Tells the output (interactor) to fetch upcoming movies
    func fetchMovies()
}

class MoviesViewController: UIViewController {

    // The collection view to show the movies and change exhibition
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieVoteAverage: UILabel!
    @IBOutlet private weak var TitleLeading: NSLayoutConstraint!
    @IBOutlet private weak var VoteAverageTrailing: NSLayoutConstraint!
    
    // Create a full-size poster size
    lazy var posterSize: CGSize = {
        return CGSize(width: collectionView.bounds.width - 40, height: collectionView.bounds.height)
    }()
    
    /// Index of current cell
    open var currentIndex: Int {
        guard let collectionView = self.collectionView else { return 0 }
        
        let startOffset = (collectionView.bounds.size.width - posterSize.width) / 2
        guard let collectionLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        
        let minimumLineSpacing = collectionLayout.minimumLineSpacing
        let a = collectionView.contentOffset.x + startOffset + posterSize.width / 2
        let b = posterSize.width + minimumLineSpacing
        return Int(a / b)
    }
    
    // MARK: - Variables
    
    internal var output: MoviesViewControllerOutput!
    internal var router: MoviesRouterProtocol!
    internal var moviesViewModels: [MoviesViewModel] = []
    
    // MARK: - Initializers
    
    /// Initializes an instance of _MoviesViewController_ with a configurator
    ///
    /// - parameter configurator: The configurator
    ///
    /// - returns: The instance of _MoviesViewController_
    init(configurator: MoviesConfigurator = MoviesConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure(configurator: configurator)
    }
    
    /// Initializes an instance of _MoviesViewController_ from storyboard
    ///
    /// - parameter coder: The coder
    ///
    /// - returns: The instance of _MoviesViewController_
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure(configurator: MoviesConfigurator.sharedInstance)
    }

}

// MARK: - Event handling

extension MoviesViewController {
    
    /// Asks the output to fetch movies
    private func fetchMovies() {
        activityIndicator.startAnimating()
        output.fetchMovies()
    }
}

// MARK: Lifecycle

extension MoviesViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        fetchMovies()
    }
}

// MARK: Configs

extension MoviesViewController {
    
    // MARK: - Configurator
    
    private func configure(configurator: MoviesConfigurator = MoviesConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }

    private func commonInit() {
        let layout = MoviesFlowLayout(itemSize: posterSize)
        
        setupTitle()
        setupActivityIndicator()
        setupCollectionView(with: layout)
    }
    
    private func setupTitle() {
        title = Strings.Movies.title
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
    
    func setupCollectionView(with layout: UICollectionViewFlowLayout)  {
        collectionView.isPrefetchingEnabled = false
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0)

        // Register collection movies cell
        registerCell()
        
        // Set layout
        collectionView.collectionViewLayout = layout
        
        // Call delegate and dataSource setups
        setupDelegate()
        setupDataSource()
    }
    
    private func setupDelegate() {
        collectionView.delegate = self
    }
    
    private func setupDataSource() {
        collectionView.dataSource = self
    }
}

// MARK: UIScrollViewDelegate

extension MoviesViewController {
    
    func scrollViewDidScroll(_: UIScrollView) {
        updatePosterInfo()
    }
    
    // Set movie title from current index
    private func updatePosterInfo() {
        guard moviesViewModels.count > 0 else { return }
        let movie = moviesViewModels[currentIndex]
        movieTitle.text = movie.title
        movieVoteAverage.text = movie.voteAverage.description
    }
}


// MARK: Helpers

extension MoviesViewController {
    
    private func registerCell() {
        
        let nib = UINib(nibName: String(describing: MoviePosterCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: MoviePosterCell.self))
    }
}


// MARK: Color handler

extension MoviesViewController : Colorable {
    
    func dominantColor(_ primary: UIColor) {
        DispatchQueue.main.async {
            UIView.transition(with: self.movieTitle, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.movieTitle.textColor = primary
                self.movieVoteAverage.textColor = primary
            }, completion: nil)
        }
    }
}

// MARK: - ArtistsPresenterOutput

extension MoviesViewController : MoviesViewControllerInput, ErrorPresentable {
    func displayMovies(viewModels: [MoviesViewModel]) {
        moviesViewModels = viewModels
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        
        // Update fisrt movie title
        updatePosterInfo()
        
        let inset = (collectionView.bounds.size.width / 2 - posterSize.width / 2) + 2
        
        // Set title position
        TitleLeading.constant = inset
        
        // Set vote label position
        VoteAverageTrailing.constant = inset
        
        // Show movieTitle after fetch
        UIView.animate(withDuration: 0.2) {
            self.movieTitle.alpha = 1
        }
        
        // Show vite label after fetch
        UIView.animate(withDuration: 0.2) {
            self.movieVoteAverage.alpha = 1
        }
    }
    
    func displayError(viewModel: ErrorViewModel) {
        activityIndicator.stopAnimating()
        presentError(viewModel: viewModel)
    }
    
    
}
