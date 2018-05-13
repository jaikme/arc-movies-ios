//
//  MovieRouter.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation


// MARK: - MovieRouterProtocol

/// _MovieRouterProtocol_ is a protocol for router input behaviours
protocol MovieRouterProtocol {
    
    var viewController: MovieDetailsViewController? { get }
}


// MARK: - MoviesRouter

/// _MovieRouter_ is a class responsible for routing from _MovieViewController_
final class MovieRouter: MovieRouterProtocol {
    
    weak var viewController: MovieDetailsViewController?
    
    
    // MARK: - Initializers
    
    /// Initializes a new instance of _MovieRouter_
    ///
    /// - parameter viewController: The _MovieViewController_ to route from
    ///
    /// - returns: The instance of _MovieRouter_
    init(viewController: MovieDetailsViewController) {
        
        self.viewController = viewController
    }
}
