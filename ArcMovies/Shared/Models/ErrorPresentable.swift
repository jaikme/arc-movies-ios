//
//  ErrorPresentable.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

/// _ErrorPresentable_ is a protocol for presenting errors
protocol ErrorPresentable {
    
    /// Present an error given an error view model
    ///
    /// - parameter viewModel: The view model for the error
    func presentError(viewModel: ErrorViewModel)
}
