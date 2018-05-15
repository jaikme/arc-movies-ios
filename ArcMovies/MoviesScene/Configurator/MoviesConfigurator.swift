//
//  MoviesConfigurator.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 11/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

/// _MoviesConfigurator_ is a class responsible for configuring the VIP scene pathways for _MoviesViewController_
final class MoviesConfigurator {
    
    /// Singleton instance of _MovieConfigurator_
    static let sharedInstance = MoviesConfigurator()
    
    
    // MARK: - Configuration
    
    /// Configures the VIP scene with pathways between router, view controller, interactor and presenter
    ///
    /// - parameter viewController: The view controller
    func configure(viewController: MoviesViewController) {
        
        let router = MoviesRouter(viewController: viewController)
        let presenter = MoviesPresenter(output: viewController)
        let interactor = MoviesInteractor(output: presenter)
        
        viewController.output = interactor
        viewController.router = router
    }
}
