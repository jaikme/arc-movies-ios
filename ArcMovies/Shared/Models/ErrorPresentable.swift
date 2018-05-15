//
//  ErrorPresentable.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

/// _ErrorPresentable_ is a protocol for presenting errors
protocol ErrorPresentable {
    
    /// Present an error given an error view model
    ///
    /// - parameter viewModel: The view model for the error
    func presentError(viewModel: ErrorViewModel)
}

/// Extension of _ErrorPresentable_ protocol for common view controller error handling
extension ErrorPresentable where Self: UIViewController {
    
    /// Presents an error for a view controller using an alert
    ///
    /// - parameter viewModel: The view model for the error
    func presentError(viewModel: ErrorViewModel) {
        
        let alertController = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        
        if let buttonTitles = viewModel.buttonTitles {
            
            for title in buttonTitles {
                
                let action = UIAlertAction(title: title, style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(action)
            }
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
