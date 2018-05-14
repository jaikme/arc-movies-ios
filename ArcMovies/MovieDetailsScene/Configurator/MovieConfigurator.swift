//
//  MovieConfigurator.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

// MARK: - MovieConfigurator

/// _MovieConfigurator_ is a class responsible for configuring the VIP scene pathways for _MovieViewController_
final class MovieConfigurator {
    
    /// Singleton instance of _MovieConfigurator_
    static let sharedInstance = MovieConfigurator()
    
    
    // MARK: - Configuration
    
    /// Configures the VIP scene with pathways between router, view controller, interactor and presenter
    ///
    /// - parameter viewController: The view controller
    func configure(viewController: MovieDetailsViewController) {
        
        let router = MovieRouter(viewController: viewController)
        let presenter = MoviePresenter(output: viewController)
        let interactor = MovieInteractor(output: presenter)
        
        viewController.output = interactor
        viewController.router = router
    }
}
